{ config, lib, ... }:

let
  envUtils = import ../helpers/envVarUtils.nix { inherit lib; };

  hyprEnvList = config.my.desktops.hyprland.envVars or [];
  hyprParsed = envUtils.parseEnvVars hyprEnvList;
  desktopEnvList = config.my.desktops.envVars or [];
  desktopParsed = envUtils.parseEnvVars desktopEnvList;

  formatEnvLine = v:
    let
      comment = envUtils.formatDescription v.description;
      line = "${v.name},${v.value}";
    in
      if comment == "" then line else "${line}${comment}";
in
{
  options.my.desktops.hyprland.inlineEnvVarHandler.enable = lib.mkEnableOption "Enable inline environment variable injection into hyprland config";

  config = lib.mkIf config.my.desktops.hyprland.inlineEnvVarHandler.enable {
    wayland.windowManager.hyprland.settings.env = [
      lib.concatStringsSep "\n" (map formatEnvLine desktopParsed)
      lib.concatStringsSep "\n" (map formatEnvLine hyprParsed)
    ];   
  };
}

