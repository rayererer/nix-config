{
  pkgs,
  lib,
  config,
  ...
}: let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.hyprshade;
  blueLightCfg = cfg.blueLightFilterTimes;
in {
  options.my.desktops.hyprland = {
    hyprshade = {
      enable = lib.mkEnableOption ''
        Enable hyprshade, which will add it as a program.
      '';

      blueLightFilterTimes = {
        start = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = ''
            What time to start the blue light filter, in the format 'HH:MM:SS'.
          '';
        };

        end = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = ''
            What time to end the blue light filter, in the format 'HH:MM:SS'.
          '';
        };

        noStartStopInequalityAssertion = lib.mkEnableOption ''
          Disable the assertion for having enabled just one of the start/end
          options for hyprshade.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        assertions = [
          {
            assertion = hyprCfg.enable;
            message = ''
              Cannot enable hyprshade if Hyprland is not enabled.
            '';
          }
        ];

        home.packages = [
          pkgs.hyprshade
        ];
      }
      (lib.mkIf (blueLightCfg.start != null || blueLightCfg.end != null) {
        assertions = [
          {
            assertion = ((blueLightCfg.start != null) == (blueLightCfg.end != null)) || blueLightCfg.noStartStopInequalityAssertion;
            message = ''
              You have only set one of the start and end times, this might lead
              to the blue light filter never starting or endping. You can disable
              this assertion by enabling the 'noStartStopInequalityAssertion' option
              but it might casue issues.
            '';
          }
        ];

        wayland.windowManager.hyprland = {
          systemd.variables = ["HYPRLAND_INSTANCE_SIGNATURE"];
          settings = {
            exec = [
              "hyprshade auto"
            ];
          };
        };

        xdg.configFile."hyprshade/config.toml".text = ''
          [[shades]]
          name = "blue-light-filter"
          ${lib.optionalString (blueLightCfg.start != null) "start_time = ${blueLightCfg.start}"}
          ${lib.optionalString (blueLightCfg.end != null) "end_time = ${blueLightCfg.end}"}
        '';


        home.activation.hyprshadeSchedule = lib.hm.dag.entryAfter ["onFilesChange"] ''
          ${pkgs.hyprshade}/bin/hyprshade install
          ${pkgs.systemd}/bin/systemctl --user enable --now hyprshade.timer
        '';
      })
    ]
  );
}
