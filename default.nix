{ nativeBuildInputs, pkgs, ... }:
let
src = ./.;
cargo' = src: (builtins.fromTOML (builtins.readFile "${src}/Cargo.toml"));
cargo = cargo' src;
name = cargo.package.name;
in
pkgs.rustPlatform.buildRustPackage {
  pname = "${name}";
  version = cargo.package.version;

  inherit nativeBuildInputs src;

  cargoLock.lockFile = ./Cargo.lock;
  
  doCheck = true;
}
