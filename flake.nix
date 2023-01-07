{
  description = "My wallpaper generator";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      in rec {
        packages.default = pkgs.callPackage ./default.nix { };
        devShell = pkgs.mkShell { inputsFrom = [ packages.default ]; };
      }
    );
}
