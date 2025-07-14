{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  cfg = config.my.desktops.nvidiaIntegration;
in {
  options.my.desktops = {
    nvidiaIntegration = lib.mkOption {
      type = lib.types.bool;
      default = osConfig.graphics.nvidia.enable;
      description = "Enable the Nvidia integration module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
      
      my.desktops.envVars = [
        "LIBVA_DRIVER_NAME=nvidia"
        "__GLX_VENDOR_LIBRARY_NAME=nvidia"
      ]
    };
}
