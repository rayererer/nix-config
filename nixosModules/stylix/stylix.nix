# All stuff not directly and basically only related to stylix should be set
# outside of stylix, (e.g. fonts).
{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.myOs.stylix;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.myOs = {
    stylix = {
      enable = lib.mkEnableOption ''
        Enable the stylix module which handles styling and theming across the
        entire computer.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    stylix.enable = true;

    # Adds bloat, optional enabling in home manager in the desktops module.
    stylix.targets.qt.enable = false;
  };
}
