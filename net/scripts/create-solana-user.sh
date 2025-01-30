#!/usr/bin/env bash
set -ex

[[ $(uname) = Linux ]] || exit 1
[[ $USER = root ]] || exit 1

if grep -q lunul /etc/passwd ; then
  echo "User lunul already exists"
else
  adduser lunul --gecos "" --disabled-password --quiet
  adduser lunul sudo
  adduser lunul adm
  echo "lunul ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
  id lunul

  [[ -r /lunul-scratch/id_ecdsa ]] || exit 1
  [[ -r /lunul-scratch/id_ecdsa.pub ]] || exit 1

  sudo -u lunul bash -c "
    echo 'PATH=\"/home/lunul/.cargo/bin:$PATH\"' > /home/lunul/.profile
    mkdir -p /home/lunul/.ssh/
    cd /home/lunul/.ssh/
    cp /lunul-scratch/id_ecdsa.pub authorized_keys
    umask 377
    cp /lunul-scratch/id_ecdsa id_ecdsa
    echo \"
      Host *
      BatchMode yes
      IdentityFile ~/.ssh/id_ecdsa
      StrictHostKeyChecking no
    \" > config
  "
fi
