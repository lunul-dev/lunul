pub const JSON_RPC_URL: &str = "http://api.devnet.lunul.com";

lazy_static! {
    pub static ref CONFIG_FILE: Option<String> = {
        dirs_next::home_dir().map(|mut path| {
            path.extend([".config", "lunul", "install", "config.yml"]);
            path.to_str().unwrap().to_string()
        })
    };
    pub static ref USER_KEYPAIR: Option<String> = {
        dirs_next::home_dir().map(|mut path| {
            path.extend([".config", "lunul", "id.json"]);
            path.to_str().unwrap().to_string()
        })
    };
    pub static ref DATA_DIR: Option<String> = {
        dirs_next::home_dir().map(|mut path| {
            path.extend([".local", "share", "lunul", "install"]);
            path.to_str().unwrap().to_string()
        })
    };
}
