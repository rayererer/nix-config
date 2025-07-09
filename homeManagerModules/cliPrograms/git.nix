{ pkgs, lib, config, ... }:

let
  cfg = config.my.cliPrograms.git;
in
{

options.my.cliPrograms = {
  git = {
    enable = lib.mkEnableOption "Enable git module.";
    withGh = lib.mkEnableOption ''
      Also download the GitHub CLI to e.g. verify for
      GitHub easier.
    '';
  };
};

config = lib.mkIf cfg.enable {
  programs = {
    git = {
      enable = true;

      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    gh = lib.mkIf cfg.withGh {
      enable = true;
    };
  };
};

}
