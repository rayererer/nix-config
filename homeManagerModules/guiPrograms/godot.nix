{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.guiPrograms.godot;
in {
  options.my.guiPrograms = {
    godot = {
      enable = lib.mkEnableOption "Enable the Godot game engine module.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.godot
    ];
  };
}
