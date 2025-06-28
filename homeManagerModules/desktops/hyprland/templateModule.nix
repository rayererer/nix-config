{ pkgs, lib, config, ... }: {

options = {
  my.desktops.hyprland.moduleCfg.placeHolderModuleNameHere.enable = lib.mkEnableOption "Enable placeHolderModuleNameHere module.";
};

config = lib.mkIf config.my.desktops.hyprland.moduleCfg.placeHolderModuleNameHere.enable {
  wayland.windowManager.hyprland = {
    settings = {

    };
  };
};
}
