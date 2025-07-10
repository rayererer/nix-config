# I have determined this is probably unnecessary.
# Just define the user in the configuration.nix
# as those options are just as easy and adding a
# layer of abstraction is probably just annoying
# for this.
{
  pkgs,
  lib,
  config,
  ...
}: let
  userCfg = config.myOs.users;
in {
  options.myOs = {
    users = {
      defaultUser = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Enable templateModuleNameHere module.";
      };
    };
  };

  config =
    lib.mkIf (userCfg != null) {
    };
}
