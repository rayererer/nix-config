{
  description = "NixOS config flake";

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
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
  {
    inherit pkgs system;
    nixosConfigurations.nixvm = nixpkgs.lib.nixosSystem {


      specialArgs = {inherit inputs; };

      modules = [
        ./hosts/nixvm/configuration.nix
        ./nixosModules
	inputs.home-manager.nixosModules.home-manager
      ];

    };

    hyprlandPackages = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    homeManagerModules.default = ./homeManagerModules;
  };
}
