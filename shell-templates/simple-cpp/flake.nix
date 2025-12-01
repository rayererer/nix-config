{
  description = "A Nix-flake-based C/C++ development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0"; # stable Nixpkgs

  outputs =
    { self, ... }@inputs:

    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import inputs.nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default =
          let
              co = pkgs.writeShellScriptBin "co" ''
                ${pkgs.gcc}/bin/g++ -std=c++17 -O2 -o "''${1%.*}" "$1" -Wall
              '';
              run = pkgs.writeShellScriptBin "run" ''
                ${co}/bin/co "$1" && ./''${1%.*}
              '';
          in
            pkgs.mkShell.override
              {
                # Override stdenv in order to change compiler:
                # stdenv = pkgs.clangStdenv;
              }
              {
                packages =
                  with pkgs;
                  [
                    clang-tools
                    cmake
                    codespell
                    conan
                    cppcheck
                    doxygen
                    gtest
                    lcov
                    vcpkg
                    vcpkg-tool
                    co
                    run
                  ]
                  ++ (if system == "aarch64-darwin" then [ ] else [ gdb ]);
              };
        }
      );
    };
}
