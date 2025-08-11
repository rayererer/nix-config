{
  pkgs,
  lib,
  config,
  ...
}: let
  deskCfg = config.my.desktops;
  cfg = deskCfg.cursors;
in {
  options.my.desktops = {
    cursors = {
      enable = lib.mkEnableOption ''
        Sets the cursor in its correc places, currently only got one cursor
        option to set though, and therefore no option for which one to set.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Notwaita-Black";
      size = 24;

      hyprcursor = {
        enable = deskCfg.hyprland.enable;
      };

      package = pkgs.runCommand "notwaita-black" {} ''
        mkdir -p $out/share/icons
        ln -s ${pkgs.fetchzip {
          url = "https://github.com/ful1e5/notwaita-cursor/releases/download/v1.0.0-alpha1/Notwaita-Black.tar.xz";
          hash = "sha256-ZLr0C5exHVz6jeLg0HGV+aZQbabBqsCuXPGodk2P0S8=";
        }} $out/share/icons/Notwaita-Black
      '';
    };
  };
}
