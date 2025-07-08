{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.services.templateModuleNameHere;
in
{

options.myOs.services = {
  templateModuleNameHere = {
    enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
  };
};

config = lib.mkIf cfg.enable {
  
};

}
