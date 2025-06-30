{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktops.hyprland;
  envUtils = import ../../helpers/envVarUtils.nix { inherit lib };
in
{

options.my.desktops.hyprland = {
  moduleCfg.envVarAggregator = {
    enable = lib.mkEnableOption "Enable envVarAggregator module.";
  };
  envVars = envUtils.envVarListType;
};

config = lib.mkIf cfg.moduleCfg.envVarAggregator.enable {
  # Pseudo code:
  # If withUWSM:
  # Import uwsmHandler with default
  # Import uwsmHandler with hyprland
  # Else:
  # Enable inlineHandler option.
};
}
