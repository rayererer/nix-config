{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktops.hyprland;
in
{
  # Import all hyprland modules here and enable them at the bottom.
  imports = [
    ./hyprland/default.nix
  ];

  options.my.desktops.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland.";
    withUWSM = lib.mkEnableOption "Configure Hyprland to work well with UWSM.";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
    };

    # Enable the Hyprland modules here.
    # Core is enabled by default.
    my.desktops.hyprland.moduleCfg = {
      uwsmIntegration.enable = cfg.withUWSM;
    };
  };
}
