{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktops;
  envUtils = import ../helpers/envVarUtils.nix { inherit lib; };
in
{

options.my.desktops = {
  enable = lib.mkEnableOption "Enable desktops module.";

  envVars = lib.mkOption {
    type = envUtils.envVarListType; 
    default = [];
    description = "Desktop agnostic Env Vars";
  };
};

config = lib.mkIf cfg.enable {
};

}
