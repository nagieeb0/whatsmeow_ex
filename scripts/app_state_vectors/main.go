// Generates test/whatsmeow/app_state/fixtures/go_vectors.json
// by running the vendored Go whatsmeow's own appstate code.
//
//	cd scripts/app_state_vectors && go mod tidy && go run . > ../../test/whatsmeow/app_state/fixtures/go_vectors.json
//
// It builds against the vendored Go source at ../../whatsmeow-main (gitignored;
// a checkout of tulir/whatsmeow).
//
// Every key, key id, JID and timestamp here is a made-up constant.
package main

import (
	"bytes"
	"context"
	"crypto/hmac"
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"os"
	"time"

	"google.golang.org/protobuf/proto"

	"go.mau.fi/whatsmeow/appstate"
	"go.mau.fi/whatsmeow/proto/waCommon"
	"go.mau.fi/whatsmeow/proto/waServerSync"
	"go.mau.fi/whatsmeow/store"
	"go.mau.fi/whatsmeow/types"
	"go.mau.fi/whatsmeow/util/hkdfutil"
	waLog "go.mau.fi/whatsmeow/util/log"
)

type fakeStore struct {
	keyID   []byte
	keyData []byte
	macs    map[string][]byte
}

func (f *fakeStore) PutAppStateSyncKey(ctx context.Context, id []byte, key store.AppStateSyncKey) error {
	return nil
}
func (f *fakeStore) GetAppStateSyncKey(ctx context.Context, id []byte) (*store.AppStateSyncKey, error) {
	if bytes.Equal(id, f.keyID) {
		return &store.AppStateSyncKey{Data: f.keyData}, nil
	}
	return nil, nil
}
func (f *fakeStore) GetLatestAppStateSyncKeyID(ctx context.Context) ([]byte, error) {
	return f.keyID, nil
}
func (f *fakeStore) GetAllAppStateSyncKeys(ctx context.Context) ([]*store.AppStateSyncKey, error) {
	return nil, nil
}
func (f *fakeStore) PutAppStateVersion(ctx context.Context, name string, version uint64, hash [128]byte) error {
	return nil
}
func (f *fakeStore) GetAppStateVersion(ctx context.Context, name string) (uint64, [128]byte, error) {
	return 0, [128]byte{}, nil
}
func (f *fakeStore) DeleteAppStateVersion(ctx context.Context, name string) error { return nil }
func (f *fakeStore) PutAppStateMutationMACs(ctx context.Context, name string, version uint64, m []store.AppStateMutationMAC) error {
	return nil
}
func (f *fakeStore) DeleteAppStateMutationMACs(ctx context.Context, name string, indexMACs [][]byte) error {
	return nil
}
func (f *fakeStore) GetAppStateMutationMAC(ctx context.Context, name string, indexMAC []byte) ([]byte, error) {
	return f.macs[hex.EncodeToString(indexMAC)], nil
}

type vector struct {
	Name        string `json:"name"`
	PrevVersion uint64 `json:"prev_version"`
	PrevHash    string `json:"prev_hash"`
	Patch       string `json:"patch"`
	NewHash     string `json:"new_hash"`
	NewVersion  uint64 `json:"new_version"`
	TimestampMs int64  `json:"timestamp_ms"`
}

func main() {
	ctx := context.Background()
	keyData := make([]byte, 32)
	for i := range keyData {
		keyData[i] = byte(i)
	}
	keyID := []byte{0, 0, 0, 0, 0x2a, 0x01}
	fs := &fakeStore{keyID: keyID, keyData: keyData, macs: map[string][]byte{}}

	// A previous SET on the pin index, so the archive patch's unpin mutation
	// subtracts a stored value MAC (the getPrevSetValueMAC path).
	pinIndex, _ := json.Marshal([]string{appstate.IndexPin, "1234567890@s.whatsapp.net"})
	// The index key is the first 32 bytes of the HKDF expansion (keys.go).
	indexKey := hkdfutil.SHA256(keyData, nil, []byte("WhatsApp Mutation Keys"), 160)[:32]
	mac := hmac.New(sha256.New, indexKey)
	mac.Write(pinIndex)
	pinIndexMAC := mac.Sum(nil)
	prevPinValueMAC := bytes.Repeat([]byte{0x5c}, 32)
	fs.macs[hex.EncodeToString(pinIndexMAC)] = prevPinValueMAC

	dev := &store.Device{AppStateKeys: fs, AppState: fs}
	proc := appstate.NewProcessor(dev, waLog.Noop)

	var prevHash [128]byte
	for i := range prevHash {
		prevHash[i] = byte(i * 7)
	}
	target := types.NewJID("1234567890", types.DefaultUserServer)
	ts := time.UnixMilli(1700000000123)
	lastMsg := time.Unix(1699999999, 0)

	cases := []struct {
		name  string
		patch appstate.PatchInfo
	}{
		{"archive", appstate.BuildArchive(target, true, lastMsg, nil)},
		{"unarchive", appstate.BuildArchive(target, false, lastMsg, nil)},
		{"mark_read", appstate.BuildMarkChatAsRead(target, true, lastMsg, &waCommon.MessageKey{
			RemoteJID: proto.String(target.String()),
			FromMe:    proto.Bool(false),
			ID:        proto.String("3EB0000000000000000000"),
		})},
	}

	var out []vector
	for _, c := range cases {
		c.patch.Timestamp = ts
		state := appstate.HashState{Version: 41, Hash: prevHash}
		raw, err := proc.EncodePatch(ctx, keyID, state, c.patch)
		if err != nil {
			panic(err)
		}
		// Decode it back with Go's own verifier, as the server would hand it to
		// another device: the server stamps the version.
		var p waServerSync.SyncdPatch
		if err := proto.Unmarshal(raw, &p); err != nil {
			panic(err)
		}
		p.Version = &waServerSync.SyncdVersion{Version: proto.Uint64(42)}
		_, newState, err := proc.DecodePatches(ctx, &appstate.PatchList{
			Name:    appstate.WAPatchRegularLow,
			Patches: []*waServerSync.SyncdPatch{&p},
		}, state, true)
		if err != nil {
			panic(err)
		}
		out = append(out, vector{
			Name:        c.name,
			PrevVersion: 41,
			PrevHash:    hex.EncodeToString(prevHash[:]),
			Patch:       hex.EncodeToString(raw),
			NewHash:     hex.EncodeToString(newState.Hash[:]),
			NewVersion:  newState.Version,
			TimestampMs: ts.UnixMilli(),
		})
	}
	enc := json.NewEncoder(os.Stdout)
	enc.SetIndent("", "  ")
	if err := enc.Encode(map[string]any{
		"key_data":           hex.EncodeToString(keyData),
		"key_id":             hex.EncodeToString(keyID),
		"pin_index_mac":      hex.EncodeToString(pinIndexMAC),
		"prev_pin_value_mac": hex.EncodeToString(prevPinValueMAC),
		"vectors":            out,
	}); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
