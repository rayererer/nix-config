{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.desktops.niri;
in {
  options.myOs.desktops.niri = {
    enable = lib.mkEnableOption "Enable niri, uses flake.";
    useUnstable = lib.mkEnableOption ''
      Sets the niri package to latest unstable.
    '';
  };

  config = lib.mkIf cfg.enable {
    # Enable cachix so that the niri package can take advantage of
    # caching so that building niri on your own is not required.
    # nix.settings = {
    #   substituters = ["https://niri.cachix.org"];
    #   trusted-substituters = ["https://niri.cachix.org"];
    #   trusted-public-keys = ["niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="];
    # };

    nixpkgs.overlays = [inputs.niri.overlays.niri];

    programs.niri = {
      enable = true;
      # Stable is already default, so no need to set it explicitly.
      package =
        lib.mkIf cfg.useUnstable
        pkgs.niri-unstable;
    };
  };
}
