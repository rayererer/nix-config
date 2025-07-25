{
  pkgs,
  lib,
  config,
  ...
}: let
  shellCfg = config.my.shells;
  cfg = shellCfg.fish;
in {
  options.my.shells.fish = {
    enable = lib.mkEnableOption "Enable the fish shell.";
  };

  config = lib.mkIf cfg.enable {
    my.shells.shells = ["fish"];

    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        # Vi mode
        fish_vi_key_bindings

        set fish_greeting ""
      '';
    };
  };
}
