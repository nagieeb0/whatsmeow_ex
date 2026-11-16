#!/usr/bin/env bash
# Build/run the app-state vector tool against Go whatsmeow's REAL `appstate` package.
#
#   run.sh gen            regenerate test/fixtures/app_state/go_vectors.json
#   run.sh build OUT_DIR  build OUT_DIR/govec (used by `mix test --include go_interop`)
#
# Needs `go` and network for module download. The `appstate` package is copied
# verbatim from ../../whatsmeow-main; export.go.txt only adds exported shims over
# its unexported MAC helpers. No MAC logic is re-implemented here.
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
root=$(cd "$here/../.." && pwd)
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

mkdir "$work/appstate"
cp "$here"/main.go "$here"/hmac.go "$here"/go.mod "$work"/
cp "$root"/whatsmeow-main/appstate/*.go "$work/appstate/"
cp "$here/export.go.txt" "$work/appstate/export.go"
sed -i "s#^replace .*#replace go.mau.fi/whatsmeow => $root/whatsmeow-main#" "$work/go.mod"

(cd "$work" && GOFLAGS=-mod=mod go mod tidy >/dev/null 2>&1 && go build -o govec .)

case "${1:-gen}" in
  gen)
    mkdir -p "$root/test/fixtures/app_state"
    "$work/govec" gen > "$root/test/fixtures/app_state/go_vectors.json"
    echo "wrote test/fixtures/app_state/go_vectors.json"
    ;;
  build)
    mkdir -p "${2:?usage: run.sh build OUT_DIR}"
    cp "$work/govec" "$2/govec"
    ;;
  *) echo "usage: run.sh gen | build OUT_DIR" >&2; exit 2 ;;
esac
