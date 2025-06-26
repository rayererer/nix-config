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
      # (maybe turn into option in the future.)
      systemd.enable = false;
    };

    wayland.windowManager.hyprland.settings = {
     "$mainMod" = "SUPER";

      bind = [
        "$mainMod,RETURN,exec,kitty"
        "$mainMod,BACKSPACE,exec,exit"
      ];
    };
  };
}
