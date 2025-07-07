{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.git;
in
{

options.myOs = {
  git = {
    enable = lib.mkEnableOption "Enable git module.";
    withGh = lib.mkEnableOption ''
      Also download the GitHub CLI to e.g. verify for
      GitHub easier.
    '';
  };
};

config = lib.mkIf cfg.enable {
  programs.git = {
    enable = true;

    config = {
      init.defaultBranch = "main";
    };
  };

  environment.systemPackages = lib.mkIf cfg.withGh [
    pkgs.gh
  ];
};

}
