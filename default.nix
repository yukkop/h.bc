{ nativeBuildInputs, pkgs, ... }:
let
name = "bc";
getVersion = src: (builtins.fromTOML (builtins.readFile "${src}/Cargo.toml")).package.version;
src = ./.;
in
pkgs.rustPlatform.buildRustPackage {
  pname = "${name}";
  version = getVersion src;

  inherit nativeBuildInputs src;

  cargoLock.lockFile = ./Cargo.lock;
  
  doCheck = true;
}
