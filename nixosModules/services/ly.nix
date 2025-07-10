{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    myOs.services.ly.enable = lib.mkEnableOption "Enable Ly Display Manager.";
  };

  config = lib.mkIf config.myOs.services.ly.enable {
    # Force override of config file, it usually just contains default anyways.
    # Maybe dont do this since the ly service.enable gives a config file, atleast check it before
    # environment.etc."ly/config.ini".text = lib.mkForce ''
    # allow_empty_password = false
    # vi_mode = true
    # '';

    # This for fixing a Ly issue with certain wayland compositors (including Hyprland).
    # In case more wayland compositors that need this fix are used, change this statement
    # somehow to include them.
    systemd.services.display-manager.environment = lib.optionalAttrs config.myOs.desktops.hyprland.enable {
      XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
    };

    services.displayManager.ly.enable = true;
  };
}
