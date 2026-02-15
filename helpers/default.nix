{lib}: let
  # This creates recursive importing so that every helper
  # can be accessed via helpers.subDir.helper and so that
  # there are actually nested attributes.
  importHelpers = files: importHelpers:
    lib.listToAttrs (map (
        file: let
          name = lib.strings.removeSuffix ".nix" (builtins.baseNameOf file);
          attrValue = import file {inherit lib importHelpers;};
        in {
          inherit name;
          value = attrValue;
        }
      )
      files);
in
  # Pass the helpers and subdirs here, just like with
  # imports = [ ... ];
  importHelpers [
    ./envVars
    ./users
    ./bundles
    ./quickshell
  ]
  importHelpers
