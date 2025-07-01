{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktops.templateDesktopNameHere;
in
{
options.my.desktops.templateDesktopNameHere = {
  enable = lib.mkEnableOption "Enable templateDesktopNameHere.";
};

config = lib.mkIf cfg.enable {


  assertions = [
    {
    assertion = config.my.desktops.enable;
    message = "Cannot set 'config.my.desktops.templateDesktopNameHere.enable' to true"
    + "if 'config.my.desktops.enable' is false"
    }
  ];

  # Enable the templateDesktopNameHere modules here.
  # They are imported in './default.nix'
  my.desktops.templateDesktopNameHere.moduleCfg = {
    core.enable = true;
  };
};

}
