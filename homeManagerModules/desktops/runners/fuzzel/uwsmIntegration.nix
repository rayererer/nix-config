{
  pkgs,
  lib,
  config,
  ...
}: let
  deskCfg = config.my.desktops;
  fuzzelCfg = deskCfg.runners.fuzzel;
  cfg = fuzzelCfg.uwsmIntegration;
in {
  options.my.desktops.runners.fuzzel = {
    uwsmIntegration = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = deskCfg.uwsmIntegration.enable;
        description = "Enable the uwsm integration module.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    my.desktops.runners.fuzzel.launchCommand =
      lib.mkIf (!deskCfg.app2unitIntegration.enable)
      "fuzzel --launch-prefix = \"uwsm app -- \"";
  };
}
