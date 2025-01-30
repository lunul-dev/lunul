#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"/..
cargo="$(readlink -f "./cargo")"

"$cargo" build --package lunul-install
export PATH=$PWD/target/debug:$PATH

echo "\`\`\`manpage"
lunul-install --help
echo "\`\`\`"
echo ""

commands=(init info deploy update run)

for x in "${commands[@]}"; do
    echo "\`\`\`manpage"
    lunul-install "${x}" --help
    echo "\`\`\`"
    echo ""
done
