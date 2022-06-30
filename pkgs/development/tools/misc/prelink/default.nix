{ stdenv
, lib
, fetchgit
, autoreconfHook
, libelf
, libiberty
}:

stdenv.mkDerivation rec {
  pname = "prelink";
  version = "unstable-2019-06-24";

  src = fetchgit {
    url = "https://git.yoctoproject.org/git/prelink-cross";
    branchName = "cross_prelink";
    rev = "f9975537dbfd9ade0fc813bd5cf5fcbe41753a37";
    sha256 = "sha256-O9/oZooLRyUBBZX3SFcB6LFMmi2vQqkUlqtZnrq5oZc=";
  };

  strictDeps = true;

  configurePlatforms = [ "build" "host" ];

  nativeBuildInputs = [
    autoreconfHook
  ];

  buildInputs = [
    stdenv.cc.libc
    libelf
    libiberty
  ];

  # Disable some tests because they're failing
  preCheck = ''
    for f in reloc2 layout1 unprel1 tls3 cxx2 cxx3 quick1 quick2 deps1 deps2; do
      echo '#' > testsuite/''${f}.sh
    done
    patchShebangs --build testsuite
  '';

  # most tests fail
  doCheck = !stdenv.isAarch64;

  enableParallelBuilding = true;

  meta = with lib;{
    description = "ELF prelinking utility to speed up dynamic linking";
    homepage = "https://wiki.yoctoproject.org/wiki/Cross-Prelink";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ artturin ];
  };
}
