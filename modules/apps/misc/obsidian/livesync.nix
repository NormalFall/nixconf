{ pkgs, ... }:
pkgs.buildNpmPackage rec {
  pname = "obsidian-livesync";
  version = "0.25.23";

  src = pkgs.fetchFromGitHub {
    owner = "vrtmrz";
    repo = "obsidian-livesync";
    rev = version;
    hash = "sha256-TUbJRNgOOxRm+tVSSMIw54FGsx529ZJVCbmXp2MiLJQ=";
    fetchSubmodules = true;
    deepClone = true;
  };

  nativeBuildInputs = with pkgs; [
    npmHooks.npmInstallHook
  ];

  npmDepsHash = "sha256-FWHdaYlZggsqw4jP5pJoxU/cl7x2PNa8o7ZicbmIGjk=";

  makeCacheWritable = true;

  installPhase = ''
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./main.js $out/main.js
    cp ./styles.css $out/styles.css
  '';
}
