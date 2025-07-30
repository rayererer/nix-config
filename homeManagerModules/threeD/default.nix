{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./prusaSlicer.nix
    ./freeCAD.nix
  ];
}
