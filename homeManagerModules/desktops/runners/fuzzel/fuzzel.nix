{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  deskCfg = config.my.desktops;
  cfg = deskCfg.runners.fuzzel;
in {
  options.my.desktops.runners = {
    fuzzel = {
      enable = lib.mkEnableOption "Enable the fuzzel config module.";

      launchCommand = lib.mkOption {
        type = lib.types.str;
        default = "fuzzel";
        description = ''
          The launch command to use for the fuzzel app launcher, is changed by
          some integrations for prefixes, for example.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    my.desktops.runners.runners = ["fuzzel"];

    programs.fuzzel = {
      enable = true;

      settings.main.font =
        lib.mkIf osConfig.stylix.enable
        (lib.mkForce
          "${config.stylix.fonts.monospace.name}:size=${toString config.stylix.fonts.sizes.popups}");
    };
  };
}
