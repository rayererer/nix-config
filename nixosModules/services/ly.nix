{ pkgs, lib, config, ... }: {
  
  options = {
    my.services.ly.enable = lib.mkEnableOption "Enable Ly Display Manager.";
  };

  config = lib.mkIf config.my.services.ly.enable {

    # Force override of config file, it usually just contains default anyways.
    # Maybe dont do this since the ly service.enable gives a config file, atleast check it before
    # environment.etc."ly/config.ini".text = lib.mkForce ''
      # allow_empty_password = false
      # vi_mode = true
    # '';

    services.displayManager.ly.enable = true;
  };
}
