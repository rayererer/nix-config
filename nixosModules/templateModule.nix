{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.templateModuleNameHere;
in
{

options.myOs = {
  templateModuleNameHere = {
    enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
  };
};

config = lib.mkIf cfg.enable {
  
}
