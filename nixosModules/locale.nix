{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.locale;
in {
  options.myOs = {
    locale = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config = lib.mkIf cfg.enable {
    time.timeZone = "Europe/Stockholm";

    # Probably best keeping this en_US
    i18n = {
      defaultLocale = "en_US.UTF-8";

      extraLocaleSettings = {
        LC_ADDRESS = "sv_SE.UTF-8";
        LC_IDENTIFICATION = "sv_SE.UTF-8";
        LC_MEASUREMENT = "sv_SE.UTF-8";
        LC_MONETARY = "sv_SE.UTF-8";
        LC_NAME = "sv_SE.UTF-8";
        LC_NUMERIC = "sv_SE.UTF-8";
        LC_PAPER = "sv_SE.UTF-8";
        LC_TELEPHONE = "sv_SE.UTF-8";
        LC_TIME = "sv_SE.UTF-8";
      };
    };

    services.xserver.xkb = {
      layout = "se";
      variant = "";
    };

    console = {
      keyMap = "sv-latin1";
    };
  };
}
