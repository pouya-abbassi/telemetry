{
  description = "Bildigo telemetry";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/442d407992384ed9c0e6d352de75b69079904e4e";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        buildToolsDeps = (with pkgs; [
          fish
          clang
          cmake
          ninja
        ]);

        deps = (with pkgs; [
          (drogon.override {
            sqliteSupport = false;
          })
        ]);

      in {
        inherit pkgs;

        devShells.default = pkgs.mkShell {
          nativeBuildInputs = buildToolsDeps;
          buildInputs = deps;

          shellHook =
            ''
              fish && exit
            '';
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "telemetry";
          version = "0.1.0";

          nativeBuildInputs = buildToolsDeps;
          buildInputs = deps;

          src = ./.;

          cmakeFlags = [];
        };
      }
    );
}
