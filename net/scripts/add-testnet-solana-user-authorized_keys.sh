#!/usr/bin/env bash
set -ex

[[ $(uname) = Linux ]] || exit 1
[[ $USER = root ]] || exit 1

[[ -d /home/lunul/.ssh ]] || exit 1

if [[ ${#SOLANA_PUBKEYS[@]} -eq 0 ]]; then
  echo "Warning: source lunul-user-authorized_keys.sh first"
fi

# lunul-user-authorized_keys.sh defines the public keys for users that should
# automatically be granted access to ALL testnets
for key in "${SOLANA_PUBKEYS[@]}"; do
  echo "$key" >> /lunul-scratch/authorized_keys
done

sudo -u lunul bash -c "
  cat /lunul-scratch/authorized_keys >> /home/lunul/.ssh/authorized_keys
"
