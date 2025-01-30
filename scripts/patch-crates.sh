# source this file

update_lunul_dependencies() {
  declare project_root="$1"
  declare lunul_ver="$2"
  declare tomls=()
  while IFS='' read -r line; do tomls+=("$line"); done < <(find "$project_root" -name Cargo.toml)

  sed -i -e "s#\(lunul-program = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-program = { version = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-program-test = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-program-test = { version = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-sdk = \"\).*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-sdk = { version = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-client = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-client = { version = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-cli-config = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-cli-config = { version = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-clap-utils = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-clap-utils = { version = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-account-decoder = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-account-decoder = { version = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-faucet = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-faucet = { version = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-zk-token-sdk = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(lunul-zk-token-sdk = { version = \"\)[^\"]*\(\"\)#\1=$lunul_ver\2#g" "${tomls[@]}" || return $?
}

patch_crates_io_lunul() {
  declare Cargo_toml="$1"
  declare lunul_dir="$2"
  cat >> "$Cargo_toml" <<EOF
[patch.crates-io]
EOF
patch_crates_io_lunul_no_header "$Cargo_toml" "$lunul_dir"
}

patch_crates_io_lunul_no_header() {
  declare Cargo_toml="$1"
  declare lunul_dir="$2"
  cat >> "$Cargo_toml" <<EOF
lunul-account-decoder = { path = "$lunul_dir/account-decoder" }
lunul-clap-utils = { path = "$lunul_dir/clap-utils" }
lunul-client = { path = "$lunul_dir/client" }
lunul-cli-config = { path = "$lunul_dir/cli-config" }
lunul-program = { path = "$lunul_dir/sdk/program" }
lunul-program-test = { path = "$lunul_dir/program-test" }
lunul-sdk = { path = "$lunul_dir/sdk" }
lunul-faucet = { path = "$lunul_dir/faucet" }
lunul-zk-token-sdk = { path = "$lunul_dir/zk-token-sdk" }
EOF
}
