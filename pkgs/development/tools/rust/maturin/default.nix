{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, pkg-config
, dbus
, gmp
, openssl
, Security
}:

rustPlatform.buildRustPackage rec {
  pname = "maturin";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "PyO3";
    repo = "maturin";
    rev = "v${version}";
    hash = "sha256-X5/1zEVhhdTuyXcUwC3jVv9Gblmv8LT+ftsVo8BnnZs=";
  };

  cargoHash = "sha256-PBmuPIpCwC7fr/MKFaeSd/0avoEATlxoeMHisjouAeI=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ gmp openssl ]
    ++ lib.optional stdenv.isDarwin Security
    ++ lib.optional stdenv.isLinux dbus;

  # Requires network access, fails in sandbox.
  doCheck = false;

  meta = with lib; {
    description = "Build and publish crates with pyo3 bindings as python packages";
    homepage = "https://github.com/PyO3/maturin";
    license = licenses.mit;
    maintainers = [ maintainers.danieldk ];
  };
}
