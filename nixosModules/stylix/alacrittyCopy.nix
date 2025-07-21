{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.stylix.colorSchemes.alacrittyCopy;
in {
  options.myOs.stylix.colorSchemes = {
    alacrittyCopy = {
      enable = lib.mkEnableOption "Enable the alacritty-copy color scheme.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
