{ pkgs, lib, config, ... }: {

  options.my.desktops.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland.";
    withUWSM = lib.mkEnableOption "Configure Hyprland to work well with UWSM.";
  };

  let
    cfg = config.my.desktops.hyprland;
  in {

  config = lib.mkIf cfg.enable {
    lib.mkMerge [
    (
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;

      settings = {
        "$mainMod" = "SUPER";

        bind = [
          "$mainMod,RETURN,exec,kitty"
          # "$mainMod,BACKSPACE,exec,exit"

	  # This for uwsm, that avoids causing issues on close.
          # "$mainMod,BACKSPACE,exec,uwsm stop"
        ];
      };
    };
    );

    (
    let 
      importModule = name: import (./directory + "/" + name + ".nix") { inherit config lib pkgs; };

      modules = [
        { name = "uwsmIntegration"; enabled = cfg.withUWSM.enable; }
      ];

      imports = lib.concatLists (map (mod:
        lib.optional mod.enabled (importModule mod.name)
      ) modules);
    in
    {
    imports = imports;
    };
    );
    ];
  };
  };
}
