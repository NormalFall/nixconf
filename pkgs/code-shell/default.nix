{ stdenv }:
let
  name = "code-shell";
in
stdenv.mkDerivation rec {
  inherit name;

  src = ./code-shell.sh;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    ls $src
    cp $src $out/bin/${name}
    chmod +x $out/bin/${name}

    runHook postInstall
  '';
}
