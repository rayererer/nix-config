{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  myCfg = config.my;
  deskCfg = myCfg.desktops;
  cfg = deskCfg.hyprland;
  osCfg = osConfig.myOs.desktops.hyprland;
in {
  options.my.desktops.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland.";
    useUWSM = lib.mkOption {
      type = lib.types.bool;
      default = osCfg.useUWSM;
      description = "Configure Hyprland to work well with UWSM.";
    };
  };

  config = lib.mkIf cfg.enable {
    my.desktops.desktops = [
      "hyprland"
    ];

    assertions = [
      {
        assertion = deskCfg.enable;
        message = ''
          Cannot set 'config.my.desktops.hyprland.enable' to true
          if 'config.my.desktops.enable' is false
        '';
      }
      {
        assertion = osCfg.enable;
        message = ''
          Cannot set 'config.my.desktops.hyprland.enable' to true
          if 'osConfig.myOs.desktops.hyprland.enable' is false
          since system-level support is needed.
        '';
      }
    ];

    warnings =
      if cfg.useUWSM != osCfg.useUWSM
      then [
        ''
          Manually setting 'config.my.desktops.hyprland.useUWSM' is
          not recommended as it follows 'config.myOs.desktops.hyprland.useUWSM',
          overriding to true is especially discouraged.
        ''
      ]
      else [];

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
   };

    my.desktops.uwsmIntegration.enable = cfg.useUWSM;

    # Enable the Hyprland modules here.
    # They are imported in './default.nix'
    #
    # This is a dumb system, modules should have their enabling settings just
    # inside themselves.
    my.desktops.hyprland.moduleCfg = {
      core.enable = true;
      mouse.enable = true;
      windowNavigation.enable = true;
      windowControlling.enable = true;
      appLauncher.enable = cfg.appLauncher.default != null;
      terminal.enable = myCfg.terminals.default != null;
      browser.enable = myCfg.browsers.default != null;
      monitors.enable = builtins.length cfg.monitors > 0;
      monitorNavigation.enable = builtins.length cfg.monitors > 1;
      locale.enable = true;
      envVarAggregator.enable = true;
      lyIntegration.enable = osConfig.myOs.services.ly.enable;
    };
  };
}
