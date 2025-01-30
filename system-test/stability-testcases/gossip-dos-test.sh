#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"
SOLANA_ROOT="$(cd ../..; pwd)"

logDir="$PWD"/logs
rm -rf "$logDir"
mkdir "$logDir"

lunulInstallDataDir=$PWD/releases
lunulInstallGlobalOpts=(
  --data-dir "$lunulInstallDataDir"
  --config "$lunulInstallDataDir"/config.yml
  --no-modify-path
)

# Install all the lunul versions
bootstrapInstall() {
  declare v=$1
  if [[ ! -h $lunulInstallDataDir/active_release ]]; then
    sh "$SOLANA_ROOT"/install/lunul-install-init.sh "$v" "${lunulInstallGlobalOpts[@]}"
  fi
  export PATH="$lunulInstallDataDir/active_release/bin/:$PATH"
}

bootstrapInstall "edge"
lunul-install-init --version
lunul-install-init edge
lunul-gossip --version
lunul-dos --version

killall lunul-gossip || true
lunul-gossip spy --gossip-port 8001 > "$logDir"/gossip.log 2>&1 &
lunulGossipPid=$!
echo "lunul-gossip pid: $lunulGossipPid"
sleep 5
lunul-dos --mode gossip --data-type random --data-size 1232 &
dosPid=$!
echo "lunul-dos pid: $dosPid"

pass=true

SECONDS=
while ((SECONDS < 600)); do
  if ! kill -0 $lunulGossipPid; then
    echo "lunul-gossip is no longer running after $SECONDS seconds"
    pass=false
    break
  fi
  if ! kill -0 $dosPid; then
    echo "lunul-dos is no longer running after $SECONDS seconds"
    pass=false
    break
  fi
  sleep 1
done

kill $lunulGossipPid || true
kill $dosPid || true
wait || true

$pass && echo Pass
