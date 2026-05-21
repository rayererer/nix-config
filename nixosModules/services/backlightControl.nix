{
  pkgs,
  lib,
  config,
  ...
}:
let
  brightnessBin = "${pkgs.brightnessctl}/bin/brightnessctl";
  cfg = config.myOs.services.backlightControl;
in
{
  options.myOs.services = {
    backlightControl = {
      enable = lib.mkEnableOption ''
        Enable the brightnessctl program and keybindings to control it.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.brightnessctl
    ];

    services.triggerhappy = {
      enable = true;
      user = "root";

      bindings = [
        {
          keys = [ "BRIGHTNESSDOWN" ];
          cmd = "${brightnessBin} set 5%-";
        }
        {
          keys = [ "BRIGHTNESSUP" ];
          cmd = "${brightnessBin} set 5%+";
        }
      ];
    };
  };
}
