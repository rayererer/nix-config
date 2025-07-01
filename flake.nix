{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
