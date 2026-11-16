// Vector generator / verifier for the Elixir port of whatsmeow's appstate package.
//
//	govec gen              -> prints fixture JSON on stdout
//	govec verify < in.json -> decodes + MAC-verifies a patch (produced by the Elixir port)
//	                          with the real Go code and prints the outcome as JSON
//
// The appstate package under ./appstate is a verbatim copy of whatsmeow's, plus export.go,
// which only exposes unexported helpers. Nothing here re-implements any MAC logic.
package main

import (
	"context"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"io"
	"os"
	"time"

	"google.golang.org/protobuf/proto"

	"go.mau.fi/whatsmeow/proto/waCommon"
	"go.mau.fi/whatsmeow/proto/waServerSync"
	"go.mau.fi/whatsmeow/proto/waSyncAction"
	"go.mau.fi/whatsmeow/store"
	"go.mau.fi/whatsmeow/types"
	"go.mau.fi/whatsmeow/util/cbcutil"
	waLog "go.mau.fi/whatsmeow/util/log"

	"go.mau.fi/whatsmeow/appstate/lthash"

	"govec/appstate"
)

// ---- in-memory store -------------------------------------------------------

type memStore struct {
	keys     map[string]store.AppStateSyncKey
	versions map[string]verEntry
	macs     map[string]map[string][]byte
}

type verEntry struct {
	version uint64
	hash    [128]byte
}

func newMem() *memStore {
	return &memStore{
		keys:     map[string]store.AppStateSyncKey{},
		versions: map[string]verEntry{},
		macs:     map[string]map[string][]byte{},
	}
}

func (m *memStore) PutAppStateSyncKey(_ context.Context, id []byte, key store.AppStateSyncKey) error {
	m.keys[string(id)] = key
	return nil
}
func (m *memStore) GetAppStateSyncKey(_ context.Context, id []byte) (*store.AppStateSyncKey, error) {
	k, ok := m.keys[string(id)]
	if !ok {
		return nil, nil
	}
	return &k, nil
}
func (m *memStore) GetLatestAppStateSyncKeyID(context.Context) ([]byte, error) { return nil, nil }
func (m *memStore) GetAllAppStateSyncKeys(context.Context) ([]*store.AppStateSyncKey, error) {
	return nil, nil
}
func (m *memStore) PutAppStateVersion(_ context.Context, name string, version uint64, hash [128]byte) error {
	m.versions[name] = verEntry{version, hash}
	return nil
}
func (m *memStore) GetAppStateVersion(_ context.Context, name string) (uint64, [128]byte, error) {
	v := m.versions[name]
	return v.version, v.hash, nil
}
func (m *memStore) DeleteAppStateVersion(_ context.Context, name string) error {
	delete(m.versions, name)
	return nil
}
func (m *memStore) PutAppStateMutationMACs(_ context.Context, name string, _ uint64, ms []store.AppStateMutationMAC) error {
	if m.macs[name] == nil {
		m.macs[name] = map[string][]byte{}
	}
	for _, x := range ms {
		m.macs[name][string(x.IndexMAC)] = x.ValueMAC
	}
	return nil
}
func (m *memStore) DeleteAppStateMutationMACs(_ context.Context, name string, idx [][]byte) error {
	for _, i := range idx {
		delete(m.macs[name], string(i))
	}
	return nil
}
func (m *memStore) GetAppStateMutationMAC(_ context.Context, name string, indexMAC []byte) ([]byte, error) {
	v, ok := m.macs[name][string(indexMAC)]
	if !ok {
		return nil, nil
	}
	return v, nil
}

func (m *memStore) clone() *memStore {
	c := newMem()
	for k, v := range m.keys {
		c.keys[k] = v
	}
	for k, v := range m.versions {
		c.versions[k] = v
	}
	for n, mm := range m.macs {
		c.macs[n] = map[string][]byte{}
		for k, v := range mm {
			c.macs[n][k] = v
		}
	}
	return c
}

func newProc(m *memStore) *appstate.Processor {
	return appstate.NewProcessor(&store.Device{AppStateKeys: m, AppState: m}, waLog.Noop)
}

// ---- output types ----------------------------------------------------------

func h(b []byte) string { return hex.EncodeToString(b) }

type macPair struct {
	IndexMAC string `json:"index_mac"`
	ValueMAC string `json:"value_mac"`
}

type decodedMutation struct {
	Index     []string `json:"index"`
	Operation string   `json:"operation"`
	Version   int32    `json:"version"`
	IndexMAC  string   `json:"index_mac"`
	ValueMAC  string   `json:"value_mac"`
	Archived  *bool    `json:"archived,omitempty"`
	Read      *bool    `json:"read,omitempty"`
	Pinned    *bool    `json:"pinned,omitempty"`
	LastMsgTS *int64   `json:"last_message_timestamp,omitempty"`
	Timestamp int64    `json:"timestamp"`
	MsgKeyID  string   `json:"message_key_id,omitempty"`
}

type step struct {
	Name         string            `json:"name"`
	PatchName    string            `json:"patch_name"`
	PatchVersion uint64            `json:"patch_version"` // version the server would stamp on the patch
	Patch        string            `json:"patch"`         // hex of the serialized SyncdPatch exactly as Go sent it
	StateBefore  stateOut          `json:"state_before"`
	PriorMACs    []macPair         `json:"prior_macs"` // mutation MACs in the store before applying
	StateAfter   stateOut          `json:"state_after"`
	Mutations    []decodedMutation `json:"mutations"`
	Source       string            `json:"source"`
}

type stateOut struct {
	Version uint64 `json:"version"`
	Hash    string `json:"hash"`
}

func mutOut(ms []appstate.Mutation) []decodedMutation {
	out := make([]decodedMutation, 0, len(ms))
	for _, m := range ms {
		d := decodedMutation{
			Index:     m.Index,
			Operation: m.Operation.String(),
			Version:   m.Version,
			IndexMAC:  h(m.IndexMAC),
			ValueMAC:  h(m.ValueMAC),
			Timestamp: m.Action.GetTimestamp(),
		}
		if a := m.Action.GetArchiveChatAction(); a != nil {
			d.Archived = a.Archived
			if r := a.GetMessageRange(); r != nil {
				d.LastMsgTS = r.LastMessageTimestamp
			}
		}
		if a := m.Action.GetMarkChatAsReadAction(); a != nil {
			d.Read = a.Read
			if r := a.GetMessageRange(); r != nil {
				d.LastMsgTS = r.LastMessageTimestamp
				if len(r.Messages) > 0 {
					d.MsgKeyID = r.Messages[0].GetKey().GetID()
				}
			}
		}
		if a := m.Action.GetPinAction(); a != nil {
			d.Pinned = a.Pinned
		}
		out = append(out, d)
	}
	return out
}

func macsOf(m *memStore, name string) []macPair {
	var out []macPair
	for k, v := range m.macs[name] {
		out = append(out, macPair{h([]byte(k)), h(v)})
	}
	return out
}

func stOut(s appstate.HashState) stateOut { return stateOut{s.Version, h(s.Hash[:])} }

// applyAsServer wraps a client-encoded patch the way the server hands it back on a resync:
// the server stamps the new collection version on it.
func applyAsServer(ctx context.Context, proc *appstate.Processor, name appstate.WAPatchName, raw []byte, version uint64, st appstate.HashState) (appstate.HashState, []appstate.Mutation, error) {
	var p waServerSync.SyncdPatch
	if err := proto.Unmarshal(raw, &p); err != nil {
		return st, nil, err
	}
	p.Version = &waServerSync.SyncdVersion{Version: proto.Uint64(version)}
	list := &appstate.PatchList{Name: name, Patches: []*waServerSync.SyncdPatch{&p}}
	muts, ns, err := proc.DecodePatches(ctx, list, st, true)
	return ns, muts, err
}

// ---- gen -------------------------------------------------------------------

func seq(start, n int) []byte {
	b := make([]byte, n)
	for i := range b {
		b[i] = byte(start + i)
	}
	return b
}

func gen() {
	ctx := context.Background()
	keyData := seq(0x10, 32)
	keyID := []byte{0x00, 0x00, 0x00, 0x00, 0x00, 0x2a}
	exp := appstate.ExpandKeys(keyData)

	out := map[string]any{
		"key_data": h(keyData),
		"key_id":   h(keyID),
		"expanded": map[string]string{
			"index":            h(exp.Index),
			"value_encryption": h(exp.ValueEncryption),
			"value_mac":        h(exp.ValueMAC),
			"snapshot_mac":     h(exp.SnapshotMAC),
			"patch_mac":        h(exp.PatchMAC),
		},
	}

	// --- LTHash ---
	items := [][]byte{seq(1, 32), seq(2, 32), seq(3, 32), seq(0xf0, 32)}
	var base [128]byte
	type lt struct {
		Add    []string `json:"add"`
		Sub    []string `json:"sub"`
		Base   string   `json:"base"`
		Result string   `json:"result"`
	}
	hx := func(xs [][]byte) []string {
		o := []string{}
		for _, x := range xs {
			o = append(o, h(x))
		}
		return o
	}
	r1 := lthash.WAPatchIntegrity.SubtractThenAdd(base[:], nil, items[:3])
	r2 := lthash.WAPatchIntegrity.SubtractThenAdd(r1, items[1:2], items[3:4])
	r3 := lthash.WAPatchIntegrity.SubtractThenAdd(base[:], items[:1], nil) // pure subtract from zero: wraps mod 2^16
	out["lthash"] = []lt{
		{hx(items[:3]), []string{}, h(base[:]), h(r1)},
		{hx(items[3:4]), hx(items[1:2]), h(r1), h(r2)},
		{[]string{}, hx(items[:1]), h(base[:]), h(r3)},
	}

	// --- content / snapshot / patch MAC ---
	type cm struct {
		Op   string `json:"op"`
		Data string `json:"data"`
		KID  string `json:"key_id"`
		Key  string `json:"key"`
		MAC  string `json:"mac"`
	}
	data := seq(0x80, 48)
	out["content_mac"] = []cm{
		{"SET", h(data), h(keyID), h(exp.ValueMAC), h(appstate.ContentMAC(waServerSync.SyncdMutation_SET, data, keyID, exp.ValueMAC))},
		{"REMOVE", h(data), h(keyID), h(exp.ValueMAC), h(appstate.ContentMAC(waServerSync.SyncdMutation_REMOVE, data, keyID, exp.ValueMAC))},
	}
	var hs appstate.HashState
	hs.Version = 9
	copy(hs.Hash[:], r2)
	out["snapshot_mac"] = map[string]string{
		"hash": h(hs.Hash[:]), "version": "9", "name": "regular_low", "key": h(exp.SnapshotMAC),
		"mac": h(hs.SnapshotMAC(appstate.WAPatchRegularLow, exp.SnapshotMAC)),
	}
	pm := &waServerSync.SyncdPatch{
		SnapshotMAC: seq(0x40, 32),
		Mutations: []*waServerSync.SyncdMutation{
			{Record: &waServerSync.SyncdRecord{Value: &waServerSync.SyncdValue{Blob: append(seq(1, 20), seq(0xa0, 32)...)}}},
			{Record: &waServerSync.SyncdRecord{Value: &waServerSync.SyncdValue{Blob: append(seq(2, 20), seq(0xb0, 32)...)}}},
		},
	}
	out["patch_mac"] = map[string]any{
		"snapshot_mac": h(pm.SnapshotMAC),
		"value_macs":   []string{h(seq(0xa0, 32)), h(seq(0xb0, 32))},
		"version":      12,
		"name":         "regular_low",
		"key":          h(exp.PatchMAC),
		"mac":          h(appstate.PatchMAC(pm, appstate.WAPatchRegularLow, exp.PatchMAC, 12)),
	}

	// --- full patches, encoded by Go's EncodePatch ---
	m := newMem()
	m.keys[string(keyID)] = store.AppStateSyncKey{Data: keyData, Timestamp: 1}
	proc := newProc(m)
	name := appstate.WAPatchRegularLow
	target := types.NewJID("201141465543", types.DefaultUserServer)
	t0 := time.Unix(1_700_000_000, 0)

	var steps []step
	st := appstate.HashState{}

	// run: encode with the real EncodePatch, then apply as the server would, recording everything.
	run := func(label string, info appstate.PatchInfo) {
		before := st
		prior := macsOf(m, string(name))
		raw, err := proc.EncodePatch(ctx, keyID, st, info)
		if err != nil {
			panic(err)
		}
		ns, muts, err := applyAsServer(ctx, proc, name, raw, st.Version+1, st)
		if err != nil {
			panic(fmt.Sprintf("go failed to decode its own patch %s: %v", label, err))
		}
		steps = append(steps, step{
			Name: label, PatchName: string(name), PatchVersion: st.Version + 1, Patch: h(raw),
			StateBefore: stOut(before), PriorMACs: prior, StateAfter: stOut(ns), Mutations: mutOut(muts),
			Source: "go-EncodePatch",
		})
		st = ns
	}

	key := &waCommon.MessageKey{RemoteJID: proto.String(target.String()), FromMe: proto.Bool(false), ID: proto.String("3EB0ABCDEF0123456789")}

	// 1. archive (archive=false -> one mutation, no unpin), no message key
	p := appstate.BuildArchive(target, false, t0, nil)
	p.Timestamp = t0
	run("archive_false_first", p)
	// 2. archive=true: archive mutation REPLACES the previous SET (exercises the subtract path) + pin(false)
	p = appstate.BuildArchive(target, true, t0.Add(time.Minute), key)
	p.Timestamp = t0.Add(time.Minute)
	run("archive_true_replaces_previous", p)
	// 3. markChatAsRead with message key
	p = appstate.BuildMarkChatAsRead(target, true, t0.Add(2*time.Minute), key)
	p.Timestamp = t0.Add(2 * time.Minute)
	run("mark_read_with_key", p)
	// 4. markChatAsRead false, no key
	p = appstate.BuildMarkChatAsRead(target, false, t0.Add(3*time.Minute), nil)
	p.Timestamp = t0.Add(3 * time.Minute)
	run("mark_unread_no_key", p)
	// 5. a group JID
	grp := types.NewJID("120363025246125486", types.GroupServer)
	p = appstate.BuildArchive(grp, true, t0.Add(4*time.Minute), nil)
	p.Timestamp = t0.Add(4 * time.Minute)
	run("archive_group", p)

	// 6. a hand-built REMOVE patch (server-originated shape): removes the markChatAsRead index set in step 4.
	{
		before := st
		prior := macsOf(m, string(name))
		idxJSON, _ := json.Marshal([]string{appstate.IndexMarkChatAsRead, target.String()})
		act := &waSyncAction.SyncActionData{
			Index: idxJSON, Padding: []byte{}, Version: proto.Int32(3),
			Value: &waSyncAction.SyncActionValue{
				Timestamp:            proto.Int64(t0.Add(5 * time.Minute).UnixMilli()),
				MarkChatAsReadAction: &waSyncAction.MarkChatAsReadAction{Read: proto.Bool(false)},
			},
		}
		content, _ := proto.Marshal(act)
		enc, err := cbcutil.Encrypt(exp.ValueEncryption, nil, content)
		if err != nil {
			panic(err)
		}
		vmac := appstate.ContentMAC(waServerSync.SyncdMutation_REMOVE, enc, keyID, exp.ValueMAC)
		imac := hmacSHA256(exp.Index, idxJSON)
		mut := &waServerSync.SyncdMutation{
			Operation: waServerSync.SyncdMutation_REMOVE.Enum(),
			Record: &waServerSync.SyncdRecord{
				Index: &waServerSync.SyncdIndex{Blob: imac},
				Value: &waServerSync.SyncdValue{Blob: append(append([]byte{}, enc...), vmac...)},
				KeyID: &waServerSync.KeyId{ID: keyID},
			},
		}
		// expected post-state: take the current hash, subtract the previously-stored value MAC for imac
		ns := st
		prev, _ := m.GetAppStateMutationMAC(ctx, string(name), imac)
		if prev == nil {
			panic("remove target missing")
		}
		lthash.WAPatchIntegrity.SubtractThenAddInPlace(ns.Hash[:], [][]byte{prev}, nil)
		ns.Version++
		sp := &waServerSync.SyncdPatch{
			SnapshotMAC: ns.SnapshotMAC(name, exp.SnapshotMAC),
			KeyID:       &waServerSync.KeyId{ID: keyID},
			Mutations:   []*waServerSync.SyncdMutation{mut},
			Version:     &waServerSync.SyncdVersion{Version: proto.Uint64(ns.Version)},
		}
		sp.PatchMAC = appstate.PatchMAC(sp, name, exp.PatchMAC, ns.Version)
		raw, _ := proto.Marshal(sp)
		// Go decodes it (validating all MACs) — proves the hand-built REMOVE is valid per Go.
		var pl waServerSync.SyncdPatch
		_ = proto.Unmarshal(raw, &pl)
		list := &appstate.PatchList{Name: name, Patches: []*waServerSync.SyncdPatch{&pl}}
		muts, got, err := proc.DecodePatches(ctx, list, st, true)
		if err != nil {
			panic(fmt.Sprintf("go rejected the REMOVE patch: %v", err))
		}
		if got.Hash != ns.Hash {
			panic("remove: state mismatch")
		}
		steps = append(steps, step{
			Name: "remove_mark_read", PatchName: string(name), PatchVersion: ns.Version, Patch: h(raw),
			StateBefore: stOut(before), PriorMACs: prior, StateAfter: stOut(got), Mutations: mutOut(muts),
			Source: "go-handbuilt-REMOVE-decoded-by-go",
		})
		st = got
	}


	// 7..10. Hand-built patches whose *index repeats within one patch* — the cases
	// where "which previous MAC is subtracted" is decided by Go's validatePatch
	// closure (earlier mutation in the same patch first, then the store). Go itself
	// computes the resulting state: pass 1 decodes with MAC validation off on a
	// CLONE of the store (so Go's real closure produces the hash), the snapshot and
	// patch MACs are then derived from that state, and pass 2 decodes the finished
	// patch with validation ON against the real store. Nothing here assumes the
	// semantics; Go decides them.
	type op struct {
		remove   bool
		chat     string
		archived bool
	}
	exotic := func(label string, ops []op) {
		before := st
		prior := macsOf(m, string(name))
		var muts []*waServerSync.SyncdMutation
		for i, o := range ops {
			idxJSON, _ := json.Marshal([]string{appstate.IndexArchive, o.chat})
			act := &waSyncAction.SyncActionData{
				Index: idxJSON, Padding: []byte{}, Version: proto.Int32(3),
				Value: &waSyncAction.SyncActionValue{
					Timestamp:         proto.Int64(t0.Add(time.Duration(10+i) * time.Minute).UnixMilli()),
					ArchiveChatAction: &waSyncAction.ArchiveChatAction{Archived: proto.Bool(o.archived)},
				},
			}
			content, _ := proto.Marshal(act)
			enc, err := cbcutil.Encrypt(exp.ValueEncryption, nil, content)
			if err != nil {
				panic(err)
			}
			opKind := waServerSync.SyncdMutation_SET
			if o.remove {
				opKind = waServerSync.SyncdMutation_REMOVE
			}
			vmac := appstate.ContentMAC(opKind, enc, keyID, exp.ValueMAC)
			muts = append(muts, &waServerSync.SyncdMutation{
				Operation: opKind.Enum(),
				Record: &waServerSync.SyncdRecord{
					Index: &waServerSync.SyncdIndex{Blob: hmacSHA256(exp.Index, idxJSON)},
					Value: &waServerSync.SyncdValue{Blob: append(append([]byte{}, enc...), vmac...)},
					KeyID: &waServerSync.KeyId{ID: keyID},
				},
			})
		}
		version := st.Version + 1
		sp := &waServerSync.SyncdPatch{
			KeyID:     &waServerSync.KeyId{ID: keyID},
			Mutations: muts,
			Version:   &waServerSync.SyncdVersion{Version: proto.Uint64(version)},
		}
		// pass 1: Go computes the state (no validation, cloned store)
		probe := newProc(m.clone())
		_, ns, err := probe.DecodePatches(ctx, &appstate.PatchList{Name: name, Patches: []*waServerSync.SyncdPatch{sp}}, st, false)
		if err != nil {
			panic(fmt.Sprintf("%s: probe: %v", label, err))
		}
		sp.SnapshotMAC = ns.SnapshotMAC(name, exp.SnapshotMAC)
		sp.PatchMAC = appstate.PatchMAC(sp, name, exp.PatchMAC, version)
		raw, _ := proto.Marshal(sp)
		// pass 2: Go decodes the finished patch WITH validation, against the real store
		var pl waServerSync.SyncdPatch
		_ = proto.Unmarshal(raw, &pl)
		decoded, got, err := proc.DecodePatches(ctx, &appstate.PatchList{Name: name, Patches: []*waServerSync.SyncdPatch{&pl}}, st, true)
		if err != nil {
			panic(fmt.Sprintf("%s: go rejected its own hand-built patch: %v", label, err))
		}
		steps = append(steps, step{
			Name: label, PatchName: string(name), PatchVersion: version, Patch: h(raw),
			StateBefore: stOut(before), PriorMACs: prior, StateAfter: stOut(got), Mutations: mutOut(decoded),
			Source: "go-handbuilt-exotic-state-computed-by-go",
		})
		st = got
	}

	c1, c2, c3 := "100000000001@s.whatsapp.net", "100000000002@s.whatsapp.net", "100000000003@s.whatsapp.net"
	exotic("dup_set_same_index", []op{{false, c1, false}, {false, c1, true}})
	exotic("set_then_remove_same_patch", []op{{false, c2, true}, {true, c2, true}})
	exotic("remove_then_set_same_patch", []op{{true, c1, true}, {false, c1, false}})
	exotic("remove_without_previous_set", []op{{true, c3, true}})

	out["steps"] = steps
	enc := json.NewEncoder(os.Stdout)
	enc.SetIndent("", "  ")
	_ = enc.Encode(out)
}

func hmacSHA256(key, data []byte) []byte {
	// identical to appstate.concatAndHMAC(sha256.New, key, data)
	return concatHMAC(key, data)
}

// ---- verify ----------------------------------------------------------------

type verifyIn struct {
	KeyID        string    `json:"key_id"`
	KeyData      string    `json:"key_data"`
	PatchName    string    `json:"patch_name"`
	StateVersion uint64    `json:"state_version"`
	StateHash    string    `json:"state_hash"`
	PriorMACs    []macPair `json:"prior_macs"`
	Patch        string    `json:"patch"`
	PatchVersion uint64    `json:"patch_version"`
}

func verify() {
	var in verifyIn
	raw, _ := io.ReadAll(os.Stdin)
	if err := json.Unmarshal(raw, &in); err != nil {
		panic(err)
	}
	dec := func(s string) []byte { b, err := hex.DecodeString(s); if err != nil { panic(err) }; return b }
	m := newMem()
	m.keys[string(dec(in.KeyID))] = store.AppStateSyncKey{Data: dec(in.KeyData), Timestamp: 1}
	for _, p := range in.PriorMACs {
		m.macs[in.PatchName] = ensure(m.macs[in.PatchName])
		m.macs[in.PatchName][string(dec(p.IndexMAC))] = dec(p.ValueMAC)
	}
	var st appstate.HashState
	st.Version = in.StateVersion
	copy(st.Hash[:], dec(in.StateHash))
	proc := newProc(m)

	var p waServerSync.SyncdPatch
	if err := proto.Unmarshal(dec(in.Patch), &p); err != nil {
		printJSON(map[string]any{"ok": false, "error": "unmarshal: " + err.Error()})
		return
	}
	p.Version = &waServerSync.SyncdVersion{Version: proto.Uint64(in.PatchVersion)}
	list := &appstate.PatchList{Name: appstate.WAPatchName(in.PatchName), Patches: []*waServerSync.SyncdPatch{&p}}
	muts, ns, err := proc.DecodePatches(context.Background(), list, st, true)
	if err != nil {
		printJSON(map[string]any{"ok": false, "error": err.Error()})
		return
	}
	printJSON(map[string]any{"ok": true, "state_after": stOut(ns), "mutations": mutOut(muts)})
}

func ensure(m map[string][]byte) map[string][]byte {
	if m == nil {
		return map[string][]byte{}
	}
	return m
}

func printJSON(v any) {
	enc := json.NewEncoder(os.Stdout)
	enc.SetIndent("", "  ")
	_ = enc.Encode(v)
}

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "usage: govec gen|verify")
		os.Exit(2)
	}
	switch os.Args[1] {
	case "gen":
		gen()
	case "verify":
		verify()
	}
}
