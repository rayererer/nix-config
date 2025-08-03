{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.cliPrograms.zoxide;
in {
  options.my.cliPrograms = {
    zoxide = {
      enable = lib.mkEnableOption "Enable the zoxide module.";

      replaceCd = lib.mkEnableOption ''
        Makes zoxide replace the cd command and allows for 'cdi' for
        interactive usage.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;

      options = lib.mkIf cfg.replaceCd [
        "--cmd cd"
      ];
    };
  };
}
