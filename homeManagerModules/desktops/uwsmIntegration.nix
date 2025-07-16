{
  pkgs,
  lib,
  config,
  ...
}: let
  deskCfg = config.my.desktops;
  cfg = deskCfg.uwsmIntegration;
in {
  options.my.desktops = {
    uwsmIntegration = {
      enable = lib.mkEnableOption ''
        Enable desktop wide uwsm integration module. This should be enabled
        by a desktop module, should probably not manually enable this.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    my.desktops = {
      uwsmEnvVarHandler.enable = true;

      appLaunchPrefix = lib.mkIf (!deskCfg.app2unitIntegration.enable) "uwsm app -- ";
    };
  };
}
