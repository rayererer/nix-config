{lib, ...}: let
  # For all bundle options, mkBundleConfig should be used. This is slightly lower priority
  # than setting normally.

  # This seems to work just fine, just wrap entire config block in it. But if
  # for some reason does not work, look at the slightly more complicated
  # function below.
  mkBundleConfig = lib.mkOverride 108;

  #mkBundleConfig = settings:
  #lib.mapAttrsRecursive (path: value: lib.mkOverride 108 value) settings;

in {
  inherit mkBundleConfig;
}
