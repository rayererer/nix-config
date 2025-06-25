{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixvm = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./hosts/nixvm/configuration.nix
        ./nixosModules
	inputs.home-manager.nixosModules.home-manager
      ];
    };

    homeManagerModules.default = ./homeManagerModules;
  };
}
