{
  pkgs,
  lib,
  config,
  self,
  ...
}: let
  deskCfg = config.my.desktops;
  cfg = deskCfg.wallpapers;

  wallpapersDirName = "assets/wallpapers";
  wallpapersDir = ../../${wallpapersDirName};
in {
  options.my.desktops = {
    wallpapers = {
      enable = lib.mkEnableOption ''
        Enables handling of wallpapers.
      '';
      
      wallpaper = lib.mkOption {
        type = lib.types.str;
        default = "pink_blob_gradient.png";
        description = ''
          The file name of the wallpaper to set, it should be located in the
          base config directory under '${wallpapersDirName}/' and include the 
          file extension. (Currently sets it to all monitors and does nothing
          fancy).
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;

      settings = {
        preload = "${wallpapersDir}/${cfg.wallpaper}";
        wallpaper = ", ${wallpapersDir}/${cfg.wallpaper}";
      };
    };
  };
}
