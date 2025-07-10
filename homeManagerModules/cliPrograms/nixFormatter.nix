{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.cliPrograms.nixFormatter;
in {
  options.my.cliPrograms = {
    nixFormatter = {
      enable = lib.mkEnableOption "Enable the nix formatter module.";
    };
  };

  config = lib.mkIf cfg.enable {
    # TODO: maybe add options to decide / be able to have more nix formatters.

    home.packages = [
      pkgs.alejandra
    ];
  };
}
