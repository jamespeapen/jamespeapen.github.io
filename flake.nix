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
      rSys = with pkgs.rPackages; [
        renv
        yaml
      ];
      rData = with pkgs.rPackages; [
      ];
  in {
    devShells.default = pkgs.mkShell {
      buildInputs = sysDeps ++ rSys ++ rData;
     shellHook = ''
        mkdir -p "$HOME/.R"
        export R_LIBS_USER="$HOME/.R"
        if [[ flake.nix -nt renv.lock ]] || [[ flake.lock -nt renv.lock ]]; then
          R -q -e "renv::lockfile_write(renv::lockfile_create())"
        fi
        '';
    };
  });
}

# vim:set et sw=2 ts=2:
