{ lib
, buildGoModule
, fetchFromGitHub
, makeBinaryWrapper
}:

buildGoModule rec {
  pname = "cloud-nuke";
  version = "0.37.0";

  src = fetchFromGitHub {
    owner = "gruntwork-io";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-5kQGUO0TBoqeQNc2gmaLDju7cE3wOz/DOO34vB405SA=";
  };

  vendorHash = "sha256-4ZPLscZWF9GfNMU70TjR5+Hi/rvm43n+GvqxFUu13JU=";

  nativeBuildInputs = [
    makeBinaryWrapper
  ];

  ldflags = [
    "-s"
    "-w"
    "-X=main.VERSION=${version}"
  ];

  doCheck = false;

  postInstall = ''
    wrapProgram $out/bin/cloud-nuke --set-default DISABLE_TELEMETRY true
  '';

  meta = with lib; {
    homepage = "https://github.com/gruntwork-io/cloud-nuke";
    description = "Tool for cleaning up your cloud accounts by nuking (deleting) all resources within it";
    mainProgram = "cloud-nuke";
    changelog = "https://github.com/gruntwork-io/cloud-nuke/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
