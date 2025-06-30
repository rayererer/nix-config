{ inputs, pkgs, lib, config, ... }: {

  options = {
    home-manager-cli = { 
      enable = lib.mkEnableOption "Include the home-manager CLI as a user package"; 
    };
  };

  config = {
    home.packages = lib.mkIf config.home-manager-cli.enable [
      inputs.home-manager.packages.${pkgs.system}.home-manager
    ];
  };
}
