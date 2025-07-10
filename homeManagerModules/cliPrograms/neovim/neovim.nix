{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.cliPrograms.neovim;
in {
  options.my.cliPrograms.neovim = {
    enable = lib.mkEnableOption "Enable Neovim.";
    useNvf = lib.mkEnableOption "Enable configuring with nvf.";
    makeDefault = lib.mkEnableOption "Make Neovim the default editor.";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.neovim.enable = true;

        my.cliPrograms.neovim.moduleCfg = {
          nvf.enable = cfg.useNvf;
        };
      }

      # Maybe actually fix this:
      (lib.mkIf cfg.makeDefault {
        programs.neovim.defaultEditor = true;
        home.sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
      })
    ]
  );
}
