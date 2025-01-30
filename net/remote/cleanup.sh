#!/usr/bin/env bash

set -x
! tmux list-sessions || tmux kill-session
declare sudo=
if sudo true; then
  sudo="sudo -n"
fi

echo "pwd: $(pwd)"
for pid in lunul/*.pid; do
  pgid=$(ps opgid= "$(cat "$pid")" | tr -d '[:space:]')
  if [[ -n $pgid ]]; then
    $sudo kill -- -"$pgid"
  fi
done
if [[ -f lunul/netem.cfg ]]; then
  lunul/scripts/netem.sh delete < lunul/netem.cfg
  rm -f lunul/netem.cfg
fi
lunul/scripts/net-shaper.sh cleanup
for pattern in validator.sh boostrap-leader.sh lunul- remote- iftop validator client node; do
  echo "killing $pattern"
  pkill -f $pattern
done
