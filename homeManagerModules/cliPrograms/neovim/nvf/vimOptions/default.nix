{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./tab.nix
    ./search.nix
    ./lineNumbers.nix
    ./scroll.nix
  ];
}
