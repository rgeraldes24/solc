#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=scripts/common.sh
source "${REPO_ROOT}/scripts/common.sh"

SOLTMPDIR=$(mktemp -d -t "cmdline-test-overwriting-files-XXXXXX")

# First time it works
echo 'contract C {}' | msg_on_error --no-stderr "$HYPC" - --bin -o "$SOLTMPDIR/non-existing-stuff-to-create"

# Second time it fails
echo 'contract C {}' | "$HYPC" - --bin -o "$SOLTMPDIR/non-existing-stuff-to-create" 2>/dev/null && \
    fail "hypc did not refuse to overwrite $SOLTMPDIR/non-existing-stuff-to-create."

# Unless we force
echo 'contract C {}' | msg_on_error --no-stderr "$HYPC" - --overwrite --bin -o "$SOLTMPDIR/non-existing-stuff-to-create"

rm -r "$SOLTMPDIR"
