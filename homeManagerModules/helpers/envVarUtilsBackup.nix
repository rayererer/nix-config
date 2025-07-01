{ lib }:

{
  # A reusable env var option type
  envVarListType = lib.types.listOf (lib.types.submodule {
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
	description = "A description for the variable (optional)";
	default = null;
      };
    };
  });

  # Turns list-of-tuples into a list-of-attrs
  # parseEnvVars = vars:
    # map (v: {
      # name = builtins.elemAt v 0;
      # value = builtins.elemAt v 1;
      # description = builtins.elemAt v 2;
    # }) vars;

  # Formats the description as a shell comment or empty string if none
  formatDescription = desc:
    if desc == null || desc == "" then
      ""
    else
      "# ${desc}";
}

