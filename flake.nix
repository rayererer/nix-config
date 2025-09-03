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
      #url = "github:notashelf/nvf";

      # For the arduino language and some more stuff, only really want one
      # commit but taking the entire fork is fine for now, going back when
      # the pr gets approved.

      #Using my own repo now:
      url = "path:/home/rayer/nvf-fork";

      #url = "github:imnotpoz/nvf/4a1fc26099bdf59d01bd28647a8dfbe2502271f5";
      #url = "github:imnotpoz/nvf/be41631a84b638b854d22a489f54acbac8689e57";
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
        ];
      };
  in {
    # Generate hosts by just putting the hostname in the list.
    nixosConfigurations = lib.genAttrs ["nixdesktop" "nixschoolwsl" "nixschoolvm"] (name: makeHostConfig name);
  };
}
