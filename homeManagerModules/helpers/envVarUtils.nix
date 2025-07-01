{ lib }:

let
  envVarType = lib.types.coercedTo
    (lib.types.listOf lib.types.str)
    (lst:
      let
        name = builtins.elemAt lst 0;
        value = builtins.elemAt lst 1;
        description = if builtins.length lst > 2 then builtins.elemAt lst 2 else null;
      in {
        varName = name;
        varValue = value;
        varDescription = description;
      })
    (lib.types.submodule {
      options = {
        varName = lib.mkOption {
          type = lib.types.str;
          description = "Which variable to set.";
        };
        varValue = lib.mkOption {
          type = lib.types.str;
          description = "What value to set the var to.";
        };
        varDescription = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "A description for the variable (optional)";
        };
      };
    });

  envVarListType = lib.types.listOf envVarType;

  formatDescription = desc:
    if desc == null || desc == "" then "" else "# ${desc}";

  formatEnvLine = v:
    "${formatDescription v.varDescription}\nexport ${v.varName}=${lib.escapeShellArg v.varValue}";

in {
  inherit envVarListType formatDescription formatEnvLine;
}

