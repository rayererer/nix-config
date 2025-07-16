{
  pkgs,
  lib,
  config,
  ...
}: let
  deskCfg = config.my.desktops;
  fuzzelCfg = deskCfg.runners.fuzzel;
  cfg = fuzzelCfg.app2unitIntegration;
in {
  options.my.desktops.runners.fuzzel = {
    app2unitIntegration = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = deskCfg.app2unitIntegration.enable;
        description = "Enable the app2unit integration module.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    my.desktops.runners.fuzzel.launchCommand =
      "fuzzel --launch-prefix='app2unit --fuzzel-compat --'";
  };
}
