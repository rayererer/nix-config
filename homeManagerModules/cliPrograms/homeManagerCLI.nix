{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.cliPrograms.homeManagerCLI;
in {
  options.my.cliPrograms.homeManagerCLI = {
    enable = lib.mkEnableOption "Include the Home Manager CLI as a user package";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.home-manager.packages.${pkgs.system}.home-manager
    ];
  };
}
