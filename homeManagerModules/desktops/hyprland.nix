{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktops.hyprland;

  # Import a module by name from the hyprland directory, passing needed args
  # Don't pass config, as it will lead to infinite recursion, might be fixable
  # somehow though, for example by passing a subset.
  importModule = name: import ./hyprland/${name}.nix { inherit lib pkgs; };

  # Define modules and their enable flags from the config options
  modules = [
    { name = "uwsmIntegration"; enabled = cfg.withUWSM.enable; }
  ];

  # Filter enabled modules and import them
  enabledModules = lib.filter (m: m.enabled) modules;

  importedModulesConfigs = map (m: importModule m.name) enabledModules;

  # Merge all configs normally (lib.mkMerge replaces lists!)
  mergedConfigs = lib.mkMerge importedModulesConfigs;

  # Extract 'settings' attribute sets from all modules (or empty if missing)
  moduleSettingsList = map (modCfg:
    lib.attrByPath ["wayland" "windowManager" "hyprland" "settings"] modCfg {}
  ) importedModulesConfigs;

  # Deep merge function for settings: concatenate lists, error on scalar conflicts
  deepMergeSettings = lib.deepMergeAttrs (old: new:
    if lib.isList old && lib.isList new then
      old ++ new
    else if old == new then
      new
    else
      throw "Scalar conflict detected during merging: ${toString old} vs ${toString new}"
  );

  # Deep merge all settings from modules
  mergedSettings = lib.foldl' deepMergeSettings {} moduleSettingsList;

  # The main settings taht will be merged with the modules settings
  mainSettings = {
    "$mainMod" = "SUPER";

    bind = [
      "$mainMod,RETURN,exec,kitty"
      # "$mainMod,BACKSPACE,exec,exit"
      # "$mainMod,BACKSPACE,exec,uwsm stop"
    ];
  };

  # Final settings: combine mainSettings and merged module settings
  finalSettings = deepMergeSettings mergedSettings mainSettings;

  # Combine the rest of the config and override settings with the merged result
  finalConfig = lib.recursiveUpdate mergedConfigs {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      settings = finalSettings;
    };
  };

in
{
  options.my.desktops.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland.";
    withUWSM = lib.mkEnableOption "Configure Hyprland to work well with UWSM.";
    # Add more module enable options here as needed
  };

  config = lib.mkIf config.my.desktops.hyprland.enable finalConfig;
}
