#!/usr/bin/env bash
set -ex

cd "$(dirname "$0")"

# shellcheck source=net/scripts/lunul-user-authorized_keys.sh
source lunul-user-authorized_keys.sh

# lunul-user-authorized_keys.sh defines the public keys for users that should
# automatically be granted access to ALL datacenter nodes.
for i in "${!SOLANA_USERS[@]}"; do
  echo "environment=\"SOLANA_USER=${SOLANA_USERS[i]}\" ${SOLANA_PUBKEYS[i]}"
done

