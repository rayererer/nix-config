{ pkgs, lib, config, ... }: {
  
  options = {
    my.desktops.hyprland.enable = lib.mkEnableOption "Enable Hyprland.";
  };

  config = lib.mkIf config.my.desktops.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;

      # Disable systemd integration because of conflict with uwsm 
      # (maybe turn this (and other options specific to uwsm) into option in the future.)
      systemd.enable = false;
    };
    

    home.file = {
      ".config/uwsm/env-hyprland".text = ''
	# This is to "regive" control of this env var,
	# which is needed to avoid warning if externally set before,
	# which is needed to make sure ly can actually start hyprland.
        export XDG_CURRENT_DESKTOP=Hyprland
      '';
    };

    wayland.windowManager.hyprland.settings = {
     "$mainMod" = "SUPER";

      bind = [
        "$mainMod,RETURN,exec,kitty"
        # "$mainMod,BACKSPACE,exec,exit"

	# This for uwsm, that avoids causing issues on close.
        "$mainMod,BACKSPACE,exec,uwsm stop"
      ];
    };
  };
}
