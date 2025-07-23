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
      stylix.base16Scheme = {
        base00 = "181818";
        base01 = "";
        base02 = "";
        base03 = "";
        base04 = "";
        base05 = "";
        base06 = "";
        base07 = "";
        base08 = "ac4242";
        base09 = "";
        base0A = "f4bf75";
        base0B = "90a959";
        base0C = "";
        base0D = "6a9fb5";
        base0E = "";
        base0F = "";
      };
    };
}
