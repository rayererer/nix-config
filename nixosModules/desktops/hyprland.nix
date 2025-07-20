{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.desktops.hyprland;
  hyprlandPkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in {
  options.myOs.desktops.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland.";
    useUWSM = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Enable Hyprland with UWSM, default is true
        because of it being recommended by Hyprland itself.
      '';
    };
    withFlake = lib.mkEnableOption ''
      Enable usage of flake for Hyprland config, which means latest
      git version, also enables caching with cachix in that case.
    '';
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf cfg.withFlake {
        # Enable cachix so that the Hyprland package can take advantage of
        # caching so that building Hyprland on your own is not required.
        nix.settings = {
          substituters = ["https://hyprland.cachix.org"];
          trusted-substituters = ["https://hyprland.cachix.org"];
          trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
        };

        programs.hyprland = {
          package = hyprlandPkgs.hyprland;
          portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
        };
      })

      {
        programs.hyprland = {
          enable = true;
          withUWSM = cfg.useUWSM;
        };
      }
    ]
  );
}
