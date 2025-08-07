# It is recommended to use direnv for developing using this flake.
# Which is done by having a .envrc with "use flake" and running direnv allow
# if direnv is installed.
{
  description = "Template Rust shell flake using fenix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    fenix = {
      # Monthly branch gets updated 1st of every month.
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    fenix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    fenixPackages = fenix.packages.${system};

    toolchain =
      fenixPackages.default.toolchain;
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        toolchain
      ];
    };
  };
}
