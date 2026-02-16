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

  qsHelpers = helpers.quickshell.quickshellModulingUtils;

  quickshellConfig =
    let
      allComponents = qsHelpers.getAllComponents cfg.containers;
    in
    pkgs.runCommand "quickshell-config" { } ''
      mkdir -p $out/components

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

    xdg.configFile."quickshell".source = quickshellConfig;

    qt.enable = true;

    home.packages = [
      pkgs.kdePackages.qtdeclarative
    ];

    programs.quickshell = {
      enable = true;

      # I don't want to build every time and found no cache.
      # package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;

      # configs = {
      #   main = lib.path.append quickShellDir "main";
      #   # default = quickShellDir;
      # };
      #
      # activeConfig = "main";

      systemd = {
        enable = true;
        target = "graphical-session.target";
      };
    };

    my.cliPrograms.neovim.nvf.languageHandling.languages = [ "qml" ];
  };
}
