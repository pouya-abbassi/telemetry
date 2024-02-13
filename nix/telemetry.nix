{ stdenv, cmake, ninja, drogon }:
stdenv.mkDerivation {
  pname = "telemetry";
  version = "0.1.0";

  nativeBuildInputs = [ cmake ninja ];
  buildInputs = [ drogon ];

  src = ../.;

  cmakeFlags = [];
}
