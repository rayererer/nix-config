{ pkgs, lib, config, ... }:

let
  cfg = config.my.userInfo;
in
{

options.my = {
  userInfo = {
    enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    userName = lib.mkOption = {
      type = lib.types.nullOr lib.types.str;
      default = null;
      
  };
};

config = lib.mkIf cfg.enable {
  
};

}
