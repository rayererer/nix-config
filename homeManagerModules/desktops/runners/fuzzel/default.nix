{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./fuzzel.nix
    ./uwsmIntegration.nix
    ./app2unitIntegration.nix
  ];
}
