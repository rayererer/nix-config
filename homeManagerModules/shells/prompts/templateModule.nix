{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.shells.prompts.templateModuleNameHere;
in {
  options.my.shells.prompts = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
