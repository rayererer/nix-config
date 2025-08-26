{lib, ...}: let
  # For all bundle options, this should be used. This is slightly lower priority
  # than setting normally.
  #mkBundleConfig = settings:
  #lib.mapAttrsRecursive (path: value: lib.mkOverride 108 value) settings;

  mkBundleConfig = lib.mkOverride 108;

in {
  inherit mkBundleConfig;
}
