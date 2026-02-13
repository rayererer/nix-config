{
  pkgs,
  lib,
  config,
  ...
}: let
  lightBin = "${pkgs.light}/bin/light";
  cfg = config.myOs.services.backlightControl;
in {
  options.myOs.services = {
    backlightControl = {
      enable = lib.mkEnableOption ''
        Enable the light program and keybindings to control it.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.light.enable = true;

    services.triggerhappy = {
      enable = true;
      user = "root";

      bindings = [
        {
          keys = ["BRIGHTNESSDOWN"];
          cmd = "${lightBin} -U 5";
        }
        {
          keys = ["BRIGHTNESSUP"];
          cmd = "${lightBin} -A 5";
        }
      ];
    };
  };
}
