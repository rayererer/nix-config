{ config, lib, ... }:

let
  envUtils = import ../../helpers/envVarUtils.nix { inherit lib; };

  hyprEnvList = config.my.desktops.hyprland.envVars or [];
  desktopEnvList = config.my.desktops.envVars or [];

  formatEnvLine = var:
    let
      comment = envUtils.formatDescription var.description;
      line = "${var.name},${var.value}";
    in
      if comment == "" then line else "${line} ${comment}";
in
{
  options.my.desktops.hyprland.inlineEnvVarHandler.enable = lib.mkEnableOption "Enable inline environment variable injection into hyprland config";

  config = lib.mkIf config.my.desktops.hyprland.inlineEnvVarHandler.enable {
    wayland.windowManager.hyprland.settings.env =
      map formatEnvLine (desktopEnvList ++ hyprEnvList);
  };
}

