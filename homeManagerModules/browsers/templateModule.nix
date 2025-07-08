{ pkgs, lib, config, ... }:

let
  cfg = config.my.browsers.templateModuleNameHere;
in
{

options.my.browsers = {
  templateModuleNameHere = {
    enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
  };
};

config = lib.mkIf cfg.enable {
  
};

}
