#!/usr/bin/env bash

set -euo pipefail

echo "--- Cabal update"
cabal update
echo

echo "+++ Cabal configure -frelease"
cabal configure -frelease --enable-tests --enable-benchmarks
echo

echo "+++ Cabal configure"
cabal configure --enable-tests --enable-benchmarks
echo

echo "+++ haskell-language-server"
ln -sf hie-direnv.yaml hie.yaml
# hie-bios occasionally segfaults. Re-running is usually enough to overcome the
# segfault.
hie-bios check lib/core/src/Cardano/Wallet.hs || true
hie-bios check lib/core/src/Cardano/Wallet.hs
haskell-language-server lib/core/src/Cardano/Wallet.hs
haskell-language-server lib/shelley/exe/cardano-wallet.hs
echo
