#!/usr/bin/env bash

set -e

if [[ -d .vercel ]]; then
  rm -r .vercel
fi

CONFIG_FILE=vercel.json

if [[ -n $CI_TAG ]]; then
  PROJECT_NAME=docs-lunul-com
else
  eval "$(../ci/channel-info.sh)"
  case $CHANNEL in
  edge)
    PROJECT_NAME=edge-docs-lunul-com
    ;;
  beta)
    PROJECT_NAME=beta-docs-lunul-com
    ;;
  *)
    PROJECT_NAME=docs
    ;;
  esac
fi

cat > "$CONFIG_FILE" <<EOF
{
  "name": "$PROJECT_NAME",
  "scope": "$VERCEL_SCOPE",
  "redirects": [
    { "source": "/apps", "destination": "/developers" },
    { "source": "/developing/programming-model/overview", "destination": "https://lunul.com/docs/programs" },
    { "source": "/apps/break", "destination": "https://lunul.com/docs/programs/examples" },
    { "source": "/apps/drones", "destination": "https://lunul.com/docs/programs/examples" },
    { "source": "/apps/hello-world", "destination": "https://lunul.com/docs/programs/examples" },
    { "source": "/apps/javascript-api", "destination": "https://lunul.com/docs/clients/javascript" },
    { "source": "/apps/programming-faq", "destination": "https://lunul.com/docs/programs/faq" },
    { "source": "/apps/rent", "destination": "https://lunul.com/docs/core/rent" },
    { "source": "/apps/webwallet", "destination": "https://lunul.com/docs/intro/wallets" },
    { "source": "/implemented-proposals/cross-program-invocation", "destination": "https://lunul.com/docs/core/cpi" },
    { "source": "/implemented-proposals/program-derived-addresses", "destination": "https://lunul.com/docs/core/cpi#program-derived-addresses" },
    { "source": "/apps/sysvars", "destination": "/developing/runtime-facilities/sysvars" },
    { "source": "/apps/builtins", "destination": "/developing/runtime-facilities/programs" },
    { "source": "/apps/backwards-compatibility", "destination": "/developing/backwards-compatibility" },
    { "source": "/implemented-proposals/secp256k1_instruction", "destination": "/developing/runtime-facilities/programs#secp256k1-program" },
    { "source": "/implemented-proposals/implemented-proposals", "destination": "/implemented-proposals" },
    { "source": "/cli/install-lunul-cli-tools", "destination": "/cli/install" },
    { "source": "/cli/conventions", "destination": "/cli/intro" },
    { "source": "/cli/choose-a-cluster", "destination": "/cli/examples/choose-a-cluster" },
    { "source": "/cli/delegate-stake", "destination": "/cli/examples/delegate-stake" },
    { "source": "/delegate-stake", "destination": "/cli/examples/delegate-stake" },
    { "source": "/cli/sign-offchain-message", "destination": "/cli/examples/sign-offchain-message" },
    { "source": "/cli/deploy-a-program", "destination": "/cli/examples/deploy-a-program" },
    { "source": "/cli/transfer-tokens", "destination": "/cli/examples/transfer-tokens" },
    { "source": "/offline-signing/durable-nonce", "destination": "/cli/examples/durable-nonce" },
    { "source": "/offline-signing", "destination": "/cli/examples/offline-signing" },
    { "source": "/developing/test-validator", "destination": "/cli/examples/test-validator" },
    { "source": "/wallet-guide/cli", "destination": "/cli/wallets" },
    { "source": "/wallet-guide/paper-wallet", "destination": "/cli/wallets/paper" },
    { "source": "/wallet-guide/file-system-wallet", "destination": "/cli/wallets/file-system" },
    { "source": "/wallet-guide/hardware-wallet", "destination": "/cli/wallets/hardware-wallet" },
    { "source": "/wallet-guide/hardware-wallet/ledger", "destination": "/cli/wallets/hardware-wallet/ledger" },
    { "source": "/cluster/overview", "destination": "/clusters" },
    { "source": "/cluster/bench-tps", "destination": "/clusters/benchmark" },
    { "source": "/cluster/performance-metrics", "destination": "/clusters/metrics" },
    { "source": "/running-validator", "destination": "/operations" },
    { "source": "/validator/get-started/setup-a-validator", "destination": "/operations/setup-a-validator" },
    { "source": "/validator/get-started/setup-an-rpc-node", "destination": "/operations/setup-an-rpc-node" },
    { "source": "/validator/best-practices/operations", "destination": "/operations/best-practices/general" },
    { "source": "/validator/best-practices/monitoring", "destination": "/operations/best-practices/monitoring" },
    { "source": "/validator/best-practices/security", "destination": "/operations/best-practices/security" },
    { "source": "/validator/overview/running-validator-or-rpc-node", "destination": "/operations/validator-or-rpc-node" },
    { "source": "/validator/overview/validator-prerequisites", "destination": "/operations/prerequisites" },
    { "source": "/validator/overview/validator-initiatives", "destination": "/operations/validator-initiatives" },
    { "source": "/running-validator/validator-reqs", "destination": "/operations/requirements" },
    { "source": "/running-validator/validator-troubleshoot", "destination": "/operations/guides/validator-troubleshoot" },
    { "source": "/running-validator/validator-start", "destination": "/operations/guides/validator-start" },
    { "source": "/running-validator/vote-accounts", "destination": "/operations/guides/vote-accounts" },
    { "source": "/running-validator/validator-stake", "destination": "/operations/guides/validator-stake" },
    { "source": "/running-validator/validator-monitor", "destination": "/operations/guides/validator-monitor" },
    { "source": "/running-validator/validator-info", "destination": "/operations/guides/validator-info" },
    { "source": "/running-validator/validator-failover", "destination": "/operations/guides/validator-failover" },
    { "source": "/running-validator/restart-cluster", "destination": "/operations/guides/restart-cluster" },
    { "source": "/cluster/synchronization", "destination": "/consensus/synchronization" },
    { "source": "/cluster/leader-rotation", "destination": "/consensus/leader-rotation" },
    { "source": "/cluster/fork-generation", "destination": "/consensus/fork-generation" },
    { "source": "/cluster/managing-forks", "destination": "/consensus/managing-forks" },
    { "source": "/cluster/turbine-block-propagation", "destination": "/consensus/turbine-block-propagation" },
    { "source": "/cluster/commitments", "destination": "/consensus/commitments" },
    { "source": "/cluster/vote-signing", "destination": "/consensus/vote-signing" },
    { "source": "/cluster/stake-delegation-and-rewards", "destination": "/consensus/stake-delegation-and-rewards" },
    { "source": "/developing/backwards-compatibility", "destination": "/backwards-compatibility" },
    { "source": "/validator/faq", "destination": "/faq" },
    { "source": "/developing/plugins/geyser-plugins", "destination": "/validator/geyser" },
    { "source": "/validator/overview/what-is-an-rpc-node", "destination": "/what-is-an-rpc-node" },
    { "source": "/validator/overview/what-is-a-validator", "destination": "/what-is-a-validator" },
    { "source": "/developing/runtime-facilities/:path*", "destination": "/runtime/:path*" },
    { "destination": "https://lunul.com/docs/rpc/:path*", "source": "/api/:path*" },
    { "destination": "https://lunul.com/docs/rpc", "source": "/developing/clients/jsonrpc-api" },
    { "destination": "https://lunul.com/docs/rpc", "source": "/apps/jsonrpc-api" },
    { "destination": "https://lunul.com/docs/terminology", "source": "/terminology" },
    { "destination": "https://lunul.com/docs/core/rent", "source": "/developing/intro/rent" },
    { "destination": "https://lunul.com/docs/core/programs", "source": "/developing/intro/programs" },
    { "destination": "https://lunul.com/docs/core/accounts", "source": "/developing/programming-model/accounts" },
    { "destination": "https://lunul.com/docs/core/cpi", "source": "/developing/programming-model/calling-between-programs" },
    { "destination": "https://lunul.com/docs/core/runtime", "source": "/developing/programming-model/runtime" },
    { "destination": "https://lunul.com/docs/core/transactions", "source": "/developing/programming-model/transactions" },
    { "destination": "https://lunul.com/docs/core/transactions/fees", "source": "/developing/intro/transaction_fees" },
    { "destination": "https://lunul.com/docs/core/transactions/confirmation", "source": "/developing/transaction_confirmation" },
    { "destination": "https://lunul.com/docs/core/transactions/versions", "source": "/developing/versioned-transactions" },
    { "destination": "https://lunul.com/docs/core/transactions/retry", "source": "/integrations/retrying-transactions" },
    { "destination": "https://lunul.com/docs/intro/dev", "source": "/developing/programming-model/overview" },
    { "destination": "https://lunul.com/docs/advanced/lookup-tables", "source": "/developing/lookup-tables" },
    { "destination": "https://lunul.com/docs", "source": "/developers" },
    { "destination": "https://lunul.com/docs/advanced/state-compression", "source": "/learn/state-compression" },
    { "destination": "https://lunul.com/developers/guides/javascript/compressed-nfts", "source": "/developing/guides/compressed-nfts" },
    { "destination": "https://lunul.com/docs/programs", "source": "/developing/on-chain-programs/overview" },
    { "destination": "https://lunul.com/docs/programs/debugging", "source": "/developing/on-chain-programs/debugging" },
    { "destination": "https://lunul.com/docs/programs/deploying", "source": "/developing/on-chain-programs/deploying" },
    { "destination": "https://lunul.com/docs/programs/examples", "source": "/developing/on-chain-programs/examples" },
    { "destination": "https://lunul.com/docs/programs/faq", "source": "/developing/on-chain-programs/faq" },
    { "destination": "https://lunul.com/docs/programs/limitations", "source": "/developing/on-chain-programs/limitations" },
    { "destination": "https://lunul.com/docs/programs/lang-rust", "source": "/developing/on-chain-programs/developing-rust" },
    { "destination": "https://lunul.com/docs/programs/lang-c", "source": "/developing/on-chain-programs/developing-c" },
    { "destination": "https://lunul.com/docs/clients/javascript-reference", "source": "/developing/clients/javascript-reference" },
    { "destination": "https://lunul.com/docs/clients/javascript", "source": "/developing/clients/javascript-api" },
    { "destination": "https://lunul.com/docs/clients/rust", "source": "/developing/clients/rust-api" },
    { "destination": "https://lunul.com/docs/intro/dev", "source": "/getstarted/overview" },
    { "destination": "https://lunul.com/developers/guides/getstarted/hello-world-in-your-browser", "source": "/getstarted/hello-world" },
    { "destination": "https://lunul.com/developers/guides/getstarted/setup-local-development", "source": "/getstarted/local" },
    { "destination": "https://lunul.com/developers/guides/getstarted/local-rust-hello-world", "source": "/getstarted/rust" },
    { "destination": "https://lunul.com/docs/core/clusters", "source": "/clusters/rpc-endpoints" },
    { "destination": "https://lunul.com/docs/economics/staking", "source": "/staking" },
    { "destination": "https://lunul.com/docs/economics/staking/:path*", "source": "/staking/:path*" },
    { "destination": "https://lunul.com/docs/economics/inflation/:path*", "source": "/inflation/:path*" },
    { "destination": "https://lunul.com/docs/more/exchange", "source": "/integrations/exchange" },
    { "destination": "https://lunul.com/docs/intro/transaction_fees", "source": "/transaction_fees" },
    { "destination": "https://lunul.com/docs/intro/economics", "source": "/storage_rent_economics" },
    { "destination": "https://lunul.com/docs/intro/economics", "source": "/economics_overview" },
    { "destination": "https://lunul.com/docs/intro/history", "source": "/history" },
    { "destination": "https://lunul.com/docs/intro/wallets", "source": "/wallet-guide/support" },
    { "destination": "https://lunul.com/docs/intro/wallets", "source": "/wallet-guide" },
    { "destination": "https://lunul.com/docs/intro", "source": "/introduction" }
  ]
}
EOF

[[ -n $VERCEL_TOKEN ]] || {
  echo "VERCEL_TOKEN is undefined.  Needed for Vercel authentication."
  exit 1
}
vercel deploy . --local-config="$CONFIG_FILE" --confirm --token "$VERCEL_TOKEN" --prod
