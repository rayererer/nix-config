{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktops.hyprland;
  envUtils = import ../../helpers/envVarUtils.nix { inherit lib; };
in
{

options.my.desktops.hyprland = {
  moduleCfg.envVarAggregator = {
    enable = lib.mkEnableOption "Enable envVarAggregator module.";
  };
  envVars = lib.mkOption { 
    type = envUtils.envVarListType; 
    default = [];
    description = "Hyprland specific Env Vars";
  };
};

config = lib.mkIf cfg.moduleCfg.envVarAggregator.enable {
  # Pseudo code:
  # If withUWSM:
  # Enable uwsmHandler and pass env vars.
  # Else:
  # Enable inlineHandler option.
    
  my.desktops.uwsmEnvVarHandler = lib.mkIf cfg.withUWSM {
    enable = true;
    uwsmCompositorEnvVarLists = [
      [ "hyprland" cfg.envVars ] 
    ];
  };

  my.desktops.hyprland.inlineEnvVarHandler = lib.mkIf (!cfg.withUWSM) {
    enable = true;
  };
};
}
