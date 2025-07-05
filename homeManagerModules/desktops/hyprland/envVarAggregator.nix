{ pkgs, lib, config, helpers, ... }:

let
  cfg = config.my.desktops.hyprland;
  envUtils = helpers.envVars.envVarUtils;
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
    
  my.desktops.uwsmEnvVarHandler = lib.mkIf cfg.useUWSM {
    enable = true;
    uwsmCompositorEnvVarLists = [
      {
        compositorName = "hyprland";
        envVarsList = cfg.envVars;
      }
    ];
  };

  my.desktops.hyprland.inlineEnvVarHandler = lib.mkIf (!cfg.useUWSM) {
    enable = true;
  };
};
}
