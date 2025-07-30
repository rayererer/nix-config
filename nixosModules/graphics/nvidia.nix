# Look at https://nixos.wiki/wiki/Nvidia
# for reference on how to change this.
{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.graphics.nvidia;
  availableDrivers = ["proprietary" "nouveau"];
in {
  options.myOs.graphics = {
    nvidia = {
      enable = lib.mkEnableOption "Enable the module for use of Nvidia graphics cards.";
      driver = lib.mkOption {
        type = lib.types.enum availableDrivers;
        default = "nouveau";
        description = ''
          Which Nvidia driver to use, 'nouveau' is default and setting
          'proprietary' requires allowing unfree software.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf (cfg.driver == "proprietary") {
        services.xserver.videoDrivers = ["nvidia"];

        hardware.nvidia = {
          modesetting.enable = true;

          # Required to set it, but can only be true for turing and later.
          open = false;

          # Nvidia settings available via `nvidia-settings`.
          nvidiaSettings = true;

          # TODO: consider switching to legacy since my graphics card
          # might soon not be supported anymore.
          # package = config.boot.kernelPackages.nvidiaPackages.legacy_SomeLegacyBranch;

          # package = config.boot.kernelPackages.nvidiaPackages.beta;
          # package = config.boot.kernelPackages.nvidiaPackages.production;
        };
      })
    ]
  );
}
