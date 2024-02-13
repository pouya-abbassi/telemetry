{
  description = "Bildigo telemetry";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/442d407992384ed9c0e6d352de75b69079904e4e";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        mPkgs = import nixpkgs {
          inherit system;
          crossSystem = nixpkgs.lib.systems.examples.musl64 // { isStatic = true; };
        };

        buildToolsDeps = (with pkgs; [
          fish
          cmake
          ninja
        ]);

        drogon = pkgs: pkgs.drogon.override {
            sqliteSupport = false;
        };
        deps = [ drogon ];

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

        packages.default = pkgs.callPackage ./nix/telemetry.nix {
          drogon = drogon pkgs;
        };

        packages.static = mPkgs.callPackage ./nix/telemetry.nix {
          drogon = drogon mPkgs;
        };

      }
    );
}
