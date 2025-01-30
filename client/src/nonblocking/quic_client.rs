#[deprecated(
    since = "1.15.0",
    note = "Please use `lunul_quic_client::nonblocking::quic_client::QuicClientConnection` instead."
)]
pub use lunul_quic_client::nonblocking::quic_client::QuicClientConnection as QuicTpuConnection;
pub use lunul_quic_client::nonblocking::quic_client::{
    QuicClient, QuicClientCertificate, QuicLazyInitializedEndpoint,
};
