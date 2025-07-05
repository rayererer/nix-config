{
  description = "NixOS and Home Manager config flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      # url = "github:nix-community/home-manager/release-25.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, ... }@inputs: 

  let
    # system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
    lib = nixpkgs.lib;

    helpers = import ./helpers { inherit lib; };

    # makeHostConfig = name: lib.{ }
  in
  {
    nixosConfigurations.nixvm = nixpkgs.lib.nixosSystem {

      specialArgs = { inherit inputs helpers; };

      modules = [
        ./hosts/nixvm/configuration.nix
        ./nixosModules
	inputs.home-manager.nixosModules.home-manager
      ];
    };

    homeManagerModules.default = ./homeManagerModules;
  };
}
