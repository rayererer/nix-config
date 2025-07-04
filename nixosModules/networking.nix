{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.networking;
in
{

options.myOs = {
  networking = {
    enable = lib.mkEnableOption "Enable networking module.";
  };
};

config = lib.mkIf cfg.enable {
  # This is not recommended for headless systems
  # since it is a relatively bulky daemon.
  # So when needed, modularize the networking
  # config more.
  networking.networkmanager.enable = true;
};

}
