{ config, lib, compositorName, compositorEnvVars, ... }:

let
  envUtils = import ../helpers/envVarUtils.nix { inherit lib; };

  # Parse env vars from option, default empty list if none set
  envList = compositorEnvVars or [];

  parsed = envUtils.parseEnvVars envList;

  fileName = if compositorName == "default" then "env" else "env-" + compositorName;

  # Helper to format env var block with optional comment
  formatVar = v:
    "${envUtils.formatDescription v.description}export ${v.name}=${lib.escapeShellArg v.value}";
in
{
  # Optionally enable only if env vars are set:
  config = lib.mkIf (envList != []) {
    home.file.".config/uwsm/${fileName}".text = lib.concatStringsSep "\n\n" (map formatVar parsed);
  };
}

