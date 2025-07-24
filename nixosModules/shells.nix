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

in {
  config =
    {
      users.users = allUsersDefaultShells;
    };
}
