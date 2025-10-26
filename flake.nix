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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      #url = "github:notashelf/nvf/v0.8";
      #url = "github:notashelf/nvf";

      # For the arduino language and some more stuff, only really want one
      # commit but taking the entire fork is fine for now, going back when
      # the pr gets approved.

      #Using my own repo now:
      url = "git+file:///home/rayer/nvf-fork?ref=v0.8";

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

    shellTemplatesPath = ./shell-templates;

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

    templates = {
      simple-rust = {
        path = "${shellTemplatesPath}/simple-rust";
        description = ''
          The basics needed for Rust development.
        '';
      };

      simple-ruby = {
        path = "${shellTemplatesPath}/simple-ruby";
        description = ''
          The basics needed for Ruby development, taken from inscapist's template,
          be sure to read the README on https://github.com/inscapist/ruby-nix and
          probably create a README of my own.
        '';
      };

      direnv-only = {
        path = "${shellTemplatesPath}/direnv-only";
        description = ''
          Only contains a .envrc file with 'use flake' in it.
        '';
      };
    };
  };
}
