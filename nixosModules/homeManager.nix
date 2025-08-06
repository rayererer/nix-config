{
  pkgs,
  inputs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.homeManager;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.myOs.homeManager.enable = lib.mkEnableOption "Enable the home-manager integration module";

  config =
    lib.mkIf cfg.enable
    {
      home-manager.sharedModules = [
        ../homeManagerModules
      ];

      home-manager.extraSpecialArgs = {
        inherit inputs helpers;
      };
    };
}
