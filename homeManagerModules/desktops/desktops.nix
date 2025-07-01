{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktops;
in
{

options.my.desktops = {
  enable = lib.mkEnableOption "Enable desktops module.";
};

config = lib.mkIf cfg.enable {
};
}
