{ pkgs, lib, config, ... }: {
  
  options = {
    myOs.desktops.hyprland.enable = lib.mkEnableOption "Enable Hyprland.";
  };

  config = lib.mkIf config.myOs.desktops.hyprland.enable {
    
    programs.hyprland = { 
      enable = true;
      withUWSM = true;
    };

    environment.systemPackages = [
      pkgs.kitty # Required for the default Hyprland config
    ];

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland # Probably necessary for stuff:
	# pkgs.xdg-desktop-portal-gtk # Keeping it here if necessary
      ];

      # Set default in case multiple backends are installed:
      config.common.default = "xdg-desktop-portal-hyprland";
    };

    environment.sessionVariables = {
      # Optional, hint Electron apps to use Wayland.
      # NIXOS_OZONE_WL = "1";
      # Optional, workaraound for GPU/driver issues with hardware cursors.
      # WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
