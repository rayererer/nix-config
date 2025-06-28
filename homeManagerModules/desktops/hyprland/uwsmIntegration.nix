{ pkgs, lib, config, ... }: {

wayland.windowManager.hyprland = {
  # Disable systemd integration because of conflict with uwsm 
  systemd.enable = false;
};

home.file = {
  ".config/uwsm/env-hyprland".text = ''
  # This is to "regive" control of this env var,
  # which is needed to avoid warning if externally set before,
  # which is needed to make sure ly can actually start hyprland.
  export XDG_CURRENT_DESKTOP=Hyprland
'';
};

}
