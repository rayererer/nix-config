{ pkgs, lib, config, osConfig, ... }:

let
  cfg = config.my.desktops.hyprland;
  osCfg = osConfig.myOs.desktops.hyprland;
in
{
options.my.desktops.hyprland = {
  enable = lib.mkEnableOption "Enable Hyprland.";
  useUWSM = lib.mkOption {
    type = lib.types.bool;
    default = osCfg.useUWSM;
    description = "Configure Hyprland to work well with UWSM.";
  };
};

config = lib.mkIf cfg.enable {

  assertions = [
    {
      # Unclear if this is actually checking what it should.
      assertion = lib.isAttrs osConfig;
      message = ''Os Config cannot be detected, it is probably not properly imported'';
    }
    {
      assertion = config.my.desktops.enable;
      message = ''Cannot set 'config.my.desktops.hyprland.enable' to true
                  if 'config.my.desktops.enable' is false'';
    }
    {
      assertion = osConfig.myOs.desktops.hyprland.enable;
      message = ''Cannot set 'config.my.desktops.hyprland.enable' to true
                  if 'osConfig.myOs.desktops.hyprland.enable' is false
                  since system-level support is needed.'';
    }
  ];

  warnings = 
    if cfg.useUWSM != osCfg.useUWSM then
      [ ''Manually setting 'config.my.desktops.hyprland.useUWSM' is
          not recommended as it follows 'config.myOs.desktops.hyprland.useUWSM',
	  overriding to true is especially discouraged.
      '' ]
    else [];

  wayland.windowManager.hyprland = {
     enable = true;
     package = null;
     portalPackage = null;
  };

  # Enable the Hyprland modules here.
  # They are imported in './default.nix'
  my.desktops.hyprland.moduleCfg = {
    core.enable = true;
    envVarAggregator.enable = true;
    uwsmIntegration.enable = cfg.useUWSM;
    lyIntegration.enable = osConfig.myOs.services.ly.enable;
  };
};

}
