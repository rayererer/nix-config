{ config, lib, ... }:

let
  cfg = config.my.desktops.uwsmEnvVarHandler;

  envUtils = import ../helpers/envVarUtils.nix { inherit lib; };
  envLists = cfg.uwsmCompositorEnvVarLists or [];
  desktopEnvList = config.my.desktops.envVars or [];
  desktopParsed = envUtils.parseEnvVars desktopEnvList;

  # Helper to format env var block with optional comment
  formatEnvLine = v:
    "${envUtils.formatDescription v.description}\nexport ${v.name}=${lib.escapeShellArg v.value}";

  makeEnvVarFile = envListsEntry:
    let
      compositorName = builtins.elemAt envListsEntry 0;
      envList = builtins.elemAt envListsEntry 1;
      fileName = "env-${compositorName}";
      vars = envUtils.parseEnvVars envList;
      text = lib.concatStringsSep "\n\n" (map formatEnvLine vars);
    in {
      name = "\".config/uwsm/${fileName}\"";
      value = {
        text = text;
      };
    };
in
{
  options.my.desktops.uwsmEnvVarHandler = {
    enable = lib.mkEnableOption "Enable uwsmEnvVarHandler.";

    uwsmCompositorEnvVarLists = lib.mkOption {
      type = lib.types.listOf (
        lib.types.tupleOf [
          lib.types.str                      # Compositor Name 
          envUtils.envVarListType            # Env Var list.
        ]
      );
      default = [];
      description = "Lists of compositor specific env vars for uwsm to handle.";
    };
  };

  config = lib.mkIf cfg.enable 
  {
    home.file = {
      ".config/uwsm/env".text = lib.concatStringsSep "\n\n" (map formatEnvLine desktopParsed);
          }  // builtins.listToAttrs (map makeEnvVarFile envLists);
  };
}

uwsmCompositorEnvVarLists = lib.mkOption {
  type = lib.types.listOf (lib.types.submodule {
    options = {
      compositor = lib.mkOption {
        type = lib.types.str;
        description = "Name of the compositor.";
      };

      envVars = lib.mkOption {
        type = envUtils.envVarListType;
        description = "Environment variables for the compositor.";
      };
    };
  });
  default = [];
  description = "Lists of compositor-specific env vars for uwsm to handle.";
};

