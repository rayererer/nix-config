{ config, lib, ... }:

let
  envUtils = import ../helpers/envVarUtils.nix { inherit lib; };
  envList = config.my.desktops.hyprland.envVars or [];
  parsed = envUtils.parseEnvVars envList;

  formatEnvLine = v:
    let
      comment = envUtils.formatDescription v.description;
      line = "${v.name},${v.value}";
    in
      if comment == "" then line else "${comment}${line}";
in
{
  options.my.desktops.hyprland.inlineEnvVarHandler.enable = lib.mkEnableOption "Enable inline environment variable injection into hyprland config";

  config = lib.mkIf (config.my.desktops.hyprland.inlineEnvVarHandler.enable && envList != []) {
    wayland.windowManager.hyprland.settings.env = lib.concatStringsSep "\n" (map formatEnvLine parsed);
  };
}

