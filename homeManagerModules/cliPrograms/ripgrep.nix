{ pkgs, lib, config, ... }:

let
  cfg = config.my.cliPrograms.ripgrep;
in
{

options.my.cliPrograms.ripgrep = {
  enable = lib.mkEnableOption "Enable ripgrep.";
};

config = lib.mkIf cfg.enable {
  programs.ripgrep = {
    enable = true;
  };
};
}
