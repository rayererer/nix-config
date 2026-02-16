{
  inputs,
  pkgs,
  lib,
  config,
  helpers,
  ...
}:
let
  cfg = config.my.widgets.quickshell;
  quickShellDir = ../../../foreign-configs/quickshell;
  componentPath = lib.path.append quickShellDir "components";
  containerPath = lib.path.append quickShellDir "containers";
  singletonPath = lib.path.append quickShellDir "singletons";

  qsHelpers = helpers.quickshell.quickshellModulingUtils;

  quickshellConfig =
    let
      allComponents = qsHelpers.getAllComponents cfg.containers;
    in
    pkgs.runCommand "quickshell-config" { } ''
      mkdir -p $out/containers
      mkdir -p $out/components
      mkdir -p $out/singletons
      cp -r ${singletonPath}/* $out/singletons/

      ${qsHelpers.generateComponentCopyCommands componentPath allComponents}

      ${qsHelpers.generateContainerFilesFromTemplates containerPath cfg.containers}

      ${qsHelpers.generateShellQmlFile cfg.containers}
    '';
in
{
  options.my.widgets.quickshell = {
    enable = lib.mkEnableOption "Enable the use of quickshell.";

    containers = lib.mkOption {
      type = lib.types.attrsOf (lib.types.listOf lib.types.str);
      default = { };
      description = "Which containers to use with the components specified in them as lists";
      example = {
        topbar = [
          "Clock"
          "Battery"
        ];
        dropdown = [
          "Clock"
          "Volume"
        ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = builtins.length (builtins.attrNames cfg.containers) != 0;
        message = ''
          Quickshell has been enabled but no containers have been.
        '';
      }
    ];

    xdg.configFile."quickshell".source = quickshellConfig;

    # These ensure that the lsp resolves things correctly.
    qt.enable = true; # Adds ENV variable
    home.packages = [
      pkgs.kdePackages.qtdeclarative # Fixes QtQuick import
    ];

    programs.quickshell = {
      enable = true;

      systemd = {
        enable = true;
        target = "graphical-session.target";
      };
    };

    my.cliPrograms.neovim.nvf.languageHandling.languages = [ "qml" ];
  };
}
