{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.cliPrograms.tldr;
in {
  options.my.cliPrograms.tldr = {
    enable = lib.mkEnableOption ''
      Enable tldr, for easily seeing common ways to use applications and tools.
      I currently use tealdeer for the implementation.
    '';
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.tealdeer
    ];
  };
}
