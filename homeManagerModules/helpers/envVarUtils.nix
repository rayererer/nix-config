{ lib }:

{
  # A reusable env var option type
  envVarListType = lib.types.listOf (
    lib.types.tupleOf [
      lib.types.str                      # Name
      lib.types.str                      # Value
      (lib.types.nullOr lib.types.str)   # Optional description
    ]
  );

  # Turns list-of-tuples into a list-of-attrs
  parseEnvVars = vars:
    map (v: {
      name = builtins.elemAt v 0;
      value = builtins.elemAt v 1;
      description = builtins.elemAt v 2;
    }) vars;

  # Formats the description as a shell comment or empty string if none
  formatDescription = desc:
    if desc == null || desc == "" then
      ""
    else
      "# ${desc}";
}

