{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.cliPrograms.direnv;
in {
  options.my.cliPrograms = {
    direnv = {
      enable = lib.mkEnableOption "Enable the direnv module.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
