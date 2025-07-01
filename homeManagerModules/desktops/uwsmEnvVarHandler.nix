{ config, lib, ... }:

let
  cfg = config.my.desktops.uwsmEnvVarHandler;
  envUtils = import ../helpers/envVarUtils.nix { inherit lib; };

  # Lists from config or empty defaults
  compositorEnvLists = cfg.uwsmCompositorEnvVarLists or [];
  genericEnvList = config.my.desktops.envVars or [];

  # Format a single env var as a shell export with optional comment
  formatEnvLine = var:
    # "${envUtils.formatDescription var.varDescription}\nexport ${var.varName}=${lib.escapeShellArg var.varValue}";
    "export ${var.varName}=${lib.escapeShellArg var.varValue}";

  # Convert compositor env var lists into attrset entries for home.file
  compositorEnvFiles = builtins.listToAttrs (map (entry: {
    name = ".config/uwsm/env-${entry.compositorName}";
    value = {
      text = lib.concatStringsSep "\n\n" (map formatEnvLine entry.envVarsList);
    };
  }) compositorEnvLists);

  # Merge generic and compositor-specific env files
  homeFiles = {
    ".config/uwsm/env" = {
      text = lib.concatStringsSep "\n\n" (map formatEnvLine genericEnvList);
    };
  } // compositorEnvFiles;

in
{
  options.my.desktops.uwsmEnvVarHandler = {
    enable = lib.mkEnableOption "Enable uwsmEnvVarHandler.";

    uwsmCompositorEnvVarLists = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          compositorName = lib.mkOption {
            type = lib.types.str;
            description = "Name of the compositor.";
          };

          envVarsList = lib.mkOption {
            type = envUtils.envVarListType;
            description = "Environment variables for the compositor.";
          };
        };
      });
      default = [];
      description = "Lists of compositor-specific env vars for uwsm to handle.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file = homeFiles;
  };
}
