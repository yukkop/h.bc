{
  description = "";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    y-util = {
      url = "github:yukkop/y.util.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = { self, nixpkgs, rust-overlay, y-util }:
  let
    overlays = [ (import rust-overlay) ];
  in
  y-util.lib.forAllSystemsWithPkgs overlays ({ system, pkgs }:
    let
      rustToolchain = pkgs.pkgsBuildHost.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      nativeBuildInputs = [ rustToolchain pkgs.pkg-config ];
      buildInputs = with pkgs; [ 
        mermaid-cli
      ];
    in
    {
      packages.${system} = {
        default = pkgs.callPackage ./default.nix { inherit pkgs nativeBuildInputs; };
      };
    }) // {};
}
