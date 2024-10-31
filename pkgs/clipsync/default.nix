# Credit to https://gist.github.com/armenr.
{
  lib,
  stdenv,
  writeShellScript,
  wl-clipboard,
  clipnotify,
  fetchgit,
}:
let
  name = "clipsync";
in
stdenv.mkDerivation rec {
  inherit name;

  src = fetchgit {
    url = "https://gist.github.com/armenr/81b77587c1dda1d00d1c1c9541dcda94";
    hash = "sha256-yYTDprtBPDEGx0hT1NMcwyWYOcr9uCZgNabRPQzXB6s=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp $src/clipsync.sh $out/bin/${name}
    chmod +x $out/bin/${name}

    sed -i '2i export PATH=$PATH:${clipnotify}/bin:${wl-clipboard}/bin' $out/bin/${name}
    runHook postInstall
  '';
}
