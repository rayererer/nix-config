{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.cliPrograms.zipping;
in {
  options.my.cliPrograms = {
    zipping = {
      enable = lib.mkEnableOption ''
        Enable the zipping module, which installs the zip and unzip packages.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.zip
      pkgs.unzip
    ];
  };
}
