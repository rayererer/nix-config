{ pkgs, lib, config, ... }: {
  
  options = {
    my.desktops.hyprland.enable = lib.mkEnableOption "Enable Hyprland.";
  };

  config = lib.mkIf config.neovim.enable {
    
    programs.hyprland.enable = true;

    environment.systemPackages = [
      pkgs.kitty # Required for the default Hyprland config
    ];

    # Optional, hint Electron apps to use Wayland;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
}
