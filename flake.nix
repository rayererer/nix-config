{
  description = "NixOS and Home Manager config flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      # url = "github:nix-community/home-manager/release-25.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    # system = "x86_64-linux";
    lib = nixpkgs.lib;

    helpers = import ./helpers {inherit lib;};

    # Helper function to extremely easily make new hosts.
    makeHostConfig = name:
      lib.nixosSystem {
        specialArgs = {inherit inputs helpers;};

        modules = [
          ./hosts/${name}/configuration.nix
          ./nixosModules
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-wsl.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };
  in {
    # Generate hosts by just putting the hostname in the list.
    nixosConfigurations = lib.genAttrs ["nixvm" "nixdesktop" "nixschoolwsl"] (name: makeHostConfig name);

    homeManagerModules.default = ./homeManagerModules;
  };
}
