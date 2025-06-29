{ pkgs, lib, config, ... }:

let
  cfg = config.my.cliPrograms.neovim;
in
{

options.my.cliPrograms.neovim = {
  enable = lib.mkEnableOption "Enable Neovim.";
  makeDefault = lib.mkEnableOption "Make Neovim the default editor.";
};

config = lib.mkIf cfg.enable (
  lib.mkMerge [
    {
      programs.neovim.enable = true;
    }
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
