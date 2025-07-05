{ inputs, pkgs, lib, config, ... }: 

let
  cfg = config.myOs.desktops.hyprland;
  hyprlandPkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  options.myOs.desktops.hyprland = { 
    enable = lib.mkEnableOption "Enable Hyprland.";
    useUWSM = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Enable Hyprland with UWSM, default is true 
        because of it being recommended by Hyprland itself.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    
    programs.hyprland = { 
      enable = true;
      withUWSM = cfg.useUWSM;
      package = hyprlandPkgs.hyprland;
      portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
    };

    environment.systemPackages = [
      pkgs.kitty # Required for the default Hyprland config
    ];

    # xdg.portal = {
      # enable = true;
      # extraPortals = [
        # pkgs.xdg-desktop-portal-hyprland # Probably necessary for stuff:
	# # pkgs.xdg-desktop-portal-gtk # Keeping it here if necessary
      # ];

      # # Set default in case multiple backends are installed:
      # config.common.default = "xdg-desktop-portal-hyprland";
    # };

    environment.sessionVariables = {
      # Optional, hint Electron apps to use Wayland.
      # NIXOS_OZONE_WL = "1";
      # Optional, workaraound for GPU/driver issues with hardware cursors.
      # WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
