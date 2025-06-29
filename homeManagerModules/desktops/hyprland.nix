{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktops.hyprland;
in
{
  # Import all hyprland modules here and enable them at the bottom.
  # Keep uwsmIntegration last as it will wrap all needed commands.
  imports = [
    ./hyprland/core.nix
    ./hyprland/uwsmIntegration.nix
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
      settings = {

        bind = [
          "$mainMod,RETURN,exec,kitty"
	  # This for uwsm, that avoids causing issues on close.
        ] ++ (if cfg.withUWSM then 
	  [
            "$mainMod,BACKSPACE,exec,uwsm stop"
	  ] else
	  [
	    "$mainMod,BACKSPACE,exec,exit"
	  ]);
      };
    };

    # Enable the hyprland modules here and import them up top.
    my.desktops.hyprland.moduleCfg = {
      core.enable = true;
      uwsmIntegration.enable = cfg.withUWSM;
    };
  };
}
