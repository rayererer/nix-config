{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.my.guiPrograms.aseprite;
in
{
  options.my.guiPrograms = {
    aseprite = {
      enable = lib.mkEnableOption "Enable the aseprite module.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.aseprite
    ];
  };
}
