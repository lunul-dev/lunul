pub(crate) mod lunul {
    pub(crate) mod wen_restart_proto {
        include!(concat!(env!("OUT_DIR"), "/lunul.wen_restart_proto.rs"));
    }
}

pub(crate) mod last_voted_fork_slots_aggregate;
pub mod wen_restart;
