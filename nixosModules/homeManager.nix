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
  options.myOs.homeManager.enable = lib.mkEnableOption "Enable the home-manager integration module";

  config =
    lib.mkIf cfg.enable
    {
      home-manager.sharedModules = [
        inputs.self.outputs.homeManagerModules.default
      ];

      home-manager.extraSpecialArgs = {
        inherit inputs helpers;
      };
    };
}
