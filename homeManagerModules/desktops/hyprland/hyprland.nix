{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktops.hyprland;
in
{
options.my.desktops.hyprland = {
  enable = lib.mkEnableOption "Enable Hyprland.";
  withUWSM = lib.mkEnableOption "Configure Hyprland to work well with UWSM.";
};

config = lib.mkIf cfg.enable {


  assertions = [
    {
    assertion = config.my.desktops.enable;
    message = "Cannot set 'config.my.desktops.hyprland.enable' to true "
    + "if 'config.my.desktops.enable' is false";
    }
  ];

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
    uwsmIntegration.enable = cfg.withUWSM;

    # TODO, fix actual check here:
    lyIntegration.enable = true;
  };
};

}
