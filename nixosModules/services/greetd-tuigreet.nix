{
  pkgs,
  lib,
  config,
  ...
}: {
  options.myOs.services = {
    greetd-tuigreet.enable = lib.mkEnableOption "Enable Ly Display Manager.";
  };

  config = lib.mkIf config.myOs.services.greetd-tuigreet.enable {
    users.users.greeter = {
      isSystemUser = true;
      description = "Greetd greeter user";
      home = "/nonexistent";
      shell = pkgs.bash;
      extraGroups = ["video"];
    };

    services.greetd = {
      enable = true;
      package = pkgs.greetd.tuigreet;
      restart = true;
      settings = {
        default_session = {
          # Can pass more flags for config here:
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks";
          user = "greeter";
        };
      };
    };
  };
}
