{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.locale;
in
{

options.myOs = {
  locale = {
    enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
  };
};

config = lib.mkIf cfg.enable {

  time.timeZone = "Europe/Stockholm";

  # Probably best keeping this en_US
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    keyMap = "sv-latin1";
  };
};
}
