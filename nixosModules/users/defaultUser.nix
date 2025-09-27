{
  pkgs,
  lib,
  config,
  ...
}: let
  userCfg = config.myOs.users;
  userName = userCfg.defaultUser;
in {
  options.myOs = {
    users = {
      defaultUser = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          The username of which a normal user with the my default settings will
          be created.
        '';
      };
    };
  };

  config = lib.mkIf (userName != null) {
    # Don't forget to set a password with 'passwd'
    users.users."${userName}" = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "dialout"]; # "wheel" is sudo.
      # And "dialout" is for access to serial ports without root perms.
    };
  };
}
