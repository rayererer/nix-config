{
  config,
  lib,
  pkgs,
  ...
}: let
  hmUsers = lib.attrNames config.home-manager.users;

  getShellForUser = user:
    config.home-manager.users.${user}.my.shells.default or null;

  filteredUsers = lib.filter (user: getShellForUser user != null) hmUsers;

  allUsersDefaultShells = lib.genAttrs (map (user: user) filteredUsers) (user: {
    shell = pkgs.${getShellForUser user};
  });

  enableShellPrograms = lib.genAttrs (map (user: getShellForUser user) filteredUsers) (_: {
    enable = true;
  });

in {
  config =
    {
      #This causes infinite recursion.
      #programs = enableShellPrograms;

      #Not this.
      #users.users = allUsersDefaultShells;
      #And this also does not.
      #programs.fish.enable = true;
    };
}
