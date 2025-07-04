{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.sound;
in
{

options.myOs = {
  sound = {
    enable = lib.mkEnableOption "Enable sound module.";
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
};

}
