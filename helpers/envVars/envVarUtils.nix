{lib, ...}: let
  # Splits the string on the first '=' but not more to ensure proper
  # handling of env vars even with format 'VAR=weird=val' which should
  # give 'VAL = weird=val'.
  parseEnvString = str: let
    idx = builtins.stringLength (lib.strings.takeWhile (c: c != "=") str);
  in
    if idx == builtins.stringLength str
    then throw "Invalid environment variable string '${str}': must contain '='"
    else {
      name = builtins.substring 0 idx str;
      value = builtins.substring (idx + 1) (builtins.stringLength str - idx - 1) str;
      description = null;
    };

  # Handles and coerces values of env vars to make three versions possible:
  # "VAR=VAL", [ "VAR" "VAL" "Description here." ] and full attrsets;
  # { name = "VAR"; value = "VAL"; description = "Description here."; }
  envVarType =
    lib.types.coercedTo
    (lib.types.oneOf [
      (lib.types.listOf lib.types.str)
      lib.types.str
    ])
    (
      v:
        if builtins.isList v
        then let
          name = builtins.elemAt v 0;
          value = builtins.elemAt v 1;
          description =
            if builtins.length v > 2
            then builtins.elemAt v 2
            else null;
        in {
          inherit name value description;
        }
        else if builtins.isString v
        then parseEnvString v
        else throw "Invalid type for env var"
    )
    (lib.types.submodule {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
          description = "Which variable to set.";
        };
        value = lib.mkOption {
          type = lib.types.str;
          description = "What value to set the var to.";
        };
        description = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "A description for the variable (optional)";
        };
      };
    });

  envVarListType = lib.types.listOf envVarType;

  formatDescription = desc:
    if desc == null || desc == ""
    then ""
    else "# ${desc}";

  formatExportEnvLine = v: "${formatDescription v.description}\nexport ${v.name}=${lib.escapeShellArg v.value}";
in {
  inherit envVarListType formatDescription formatExportEnvLine;
}
