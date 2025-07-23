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
        base01 = "282828";
        base02 = "383838";
        base03 = "6b6b6b";
        base04 = "a8a8a8";
        base05 = "d8d8d8";
        base06 = "e8e8e8";
        base07 = "f8f8f8";

        base08 = "ac4242";
        base09 = "d08057"; # Kind of Blended from 08 and 0A
        base0A = "f4bf75";
        base0B = "90a959";
        base0C = "75b5aa";
        base0D = "6a9fb5";
        base0E = "aa759f";
        base0F = "8b7355";

        base12 = "c55555";
        base13 = "feca88";
        base14 = "aac474";
        base15 = "93d3c3";
        base16 = "82b8c8";
        base17 = "c28cb8";
      };
    };
}
