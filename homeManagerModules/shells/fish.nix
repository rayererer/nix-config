{
  pkgs,
  lib,
  config,
  ...
}: let
  termCfg = config.my.shells;
  cfg = termCfg.fish;
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
      '';
    };
  };
}
