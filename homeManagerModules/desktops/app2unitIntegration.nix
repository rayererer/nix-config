{
  pkgs,
  lib,
  config,
  ...
}: let
  deskCfg = config.my.desktops;
  cfg = deskCfg.app2unitIntegration;
in {
  options.my.desktops = {
    app2unitIntegration = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = deskCfg.uwsmIntegration.enable;
        description = ''
          Enable the app2unit integration module. Recommended if using uwsm,
          and if so auto enabled, can also be enabled otherwise though.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.app2unit
    ];

    my.desktops = {
      appLaunchPrefix = "app2unit ";

      envVars =
        lib.mkIf deskCfg.uwsmIntegration.enable
        [
          [
            "APP2UNIT_SLICES"
            "a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice"
            "Make app2unit a drop-in replacement for uwsm app launcher."
          ]
        ];
    };
  };
}
