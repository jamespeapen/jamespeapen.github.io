{
  description = "Flake to render jamespeapen.github.io";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      sysDeps = with pkgs; [
        R
        quarto
      ];
  in {
    devShells.default = pkgs.mkShell {
      buildInputs = sysDeps;
    };
  });
}

# vim:set et sw=2 ts=2:
