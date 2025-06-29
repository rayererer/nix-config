{ pkgs, lib, config, ... }: {

options = {
  my.desktops.hyprland.moduleCfg.core.enable = lib.mkEnableOption "Enable core module.";
};

config = lib.mkIf config.my.desktops.hyprland.moduleCfg.core.enable {
  wayland.windowManager.hyprland = {
    settings = {
     "$mainMod" = "SUPER";

      bind = [
        "$mainMod,RETURN,exec,kitty"
      ];
    };
  };
};
}
