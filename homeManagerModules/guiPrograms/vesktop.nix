{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.guiPrograms.vesktop;
in {
  options.my.guiPrograms = {
    vesktop = {
      enable = lib.mkEnableOption "Enable the vesktop module.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vesktop = {
      enable = true;

      settings = {
        arRPC = false;
        checkUpdates = false;
        minimizeToTray = false;
        hardwareAcceleration = true;

        discordBranch = "stable";
      };
    };

    # Make sure first launch prompt is not shown.
    home.activation.vesktopState = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD ${pkgs.coreutils}/bin/mkdir -p ~/.config/vesktop
      if [ ! -f ~/.config/vesktop/state.json ]; then
        $DRY_RUN_CMD ${pkgs.coreutils}/bin/echo '{"firstLaunch": false}' > ~/.config/vesktop/state.json
      fi
    '';
  };
}
