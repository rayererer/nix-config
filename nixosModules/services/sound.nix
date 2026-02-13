{
  pkgs,
  lib,
  config,
  ...
}: let
  userName = config.myOs.users.defaultUser;
  wpctlBin = "${pkgs.wireplumber}/bin/wpctl";
  soundCommand = "${pkgs.bash}/bin/bash -c 'XDG_RUNTIME_DIR=run/user/$(id -u ${userName}) ${wpctlBin}";

  cfg = config.myOs.services.sound;
in {
  options.myOs.services = {
    sound = {
      enable = lib.mkEnableOption "Enable sound module.";

      laptopControls.enable = lib.mkEnableOption ''
        Enable support for the volume and sound-off buttons on a laptop.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # This is for sound for a regular desktop / laptop,
    # so modularize further if other purposes are needed.
    services.pipewire = {
      enable = true;

      # Enabling alsa here makes compatibility better but can cause
      # some issues with older hardware and introduces slight latency
      # compared to completely native ALSA. If encountering issues,
      # disable and test.
      alsa.enable = true;

      pulse.enable = true;

      # Enabling JACK here seems unnecessary for regular stuff,
      # but is sometimes used for advanced audio stuff (profesional
      # applications mostly).
      # jack.enable = true;
    };

    services.triggerhappy = lib.mkIf cfg.laptopControls.enable {
      enable = true;
      user = "root";

      bindings = [
        {
          keys = ["VOLUMEDOWN"];
          cmd = "${soundCommand} set-volume @DEFAULT_AUDIO_SINK@ 5%-'";
        }
        {
          keys = ["VOLUMEUP"];
          cmd = "${soundCommand} set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.0'";
        }
        {
          keys = ["MUTE"];
          cmd = "${soundCommand} set-mute @DEFAULT_AUDIO_SINK@ toggle'";
        }
        {
          keys = ["MICMUTE"];
          cmd = "${soundCommand} set-mute @DEFAULT_AUDIO_SOURCE@ toggle'";
        }
      ];
    };
  };
}
