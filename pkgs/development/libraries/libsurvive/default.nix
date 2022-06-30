{ lib, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, freeglut
, lapack
, libusb1
, blas
, zlib
, eigen
}:

stdenv.mkDerivation rec {
  pname = "libsurvive";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "cntools";
    repo = pname;
    rev = "v${version}";
    # Fixes 'Unknown CMake command "cnkalman_generate_code"'
    fetchSubmodules = true;
    sha256 = "sha256-I8Wx9avfMyDic+Bk/1IjzZiiHj+l3XqpRwxYbWlsG/Q=";
  };

  nativeBuildInputs = [ cmake pkg-config ];

  buildInputs = [
    freeglut
    lapack
    libusb1
    blas
    zlib
    eigen
  ];

  meta = with lib; {
    description = "Open Source Lighthouse Tracking System";
    homepage = "https://github.com/cntools/libsurvive";
    license = licenses.mit;
    maintainers = with maintainers; [ expipiplus1 prusnak ];
    platforms = platforms.linux;
  };
}
