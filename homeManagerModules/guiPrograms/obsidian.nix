{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.guiPrograms.obsidian;
in {
  options.my.guiPrograms = {
    obsidian = {
      enable = lib.mkEnableOption "Enable the obsidian note taking app module.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.obsidian
    ];
  };
}
