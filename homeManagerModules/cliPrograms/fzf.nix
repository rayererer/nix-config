{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.cliPrograms.fzf;
in {
  options.my.cliPrograms = {
    fzf = {
      enable = lib.mkEnableOption ''
        Enable fzf, a terminal fuzzy finder.
      '';
    };
  };

  config =
    lib.mkIf cfg.enable {
      programs.fzf = {
        enable = true;
      };
    };
}
