{ pkgs, lib, config, ... }: {

options.my.desktops.hyprland.moduleCfg.uwsmIntegration = {
  enable = lib.mkEnableOption "Enable uwsmIntegration module that changes some settings and also wraps all needed commands.";
};

config = lib.mkIf config.my.desktops.hyprland.moduleCfg.uwsmIntegration.enable {

  wayland.windowManager.hyprland = {
    systemd.enable = false;
  };

  home = { 

  file = {
    ".config/uwsm/env-hyprland".text = ''
      # This is to "regive" control of this env var,
      # which is needed to avoid warning if externally set before,
      # which is needed to make sure ly can actually start hyprland.
      export XDG_CURRENT_DESKTOP=Hyprland

      # This is to make sure uwsm config file is used,
      # which is necessary if the wrapping of e.g. binds should work.
      export HYPRLAND_CONFIG_PATH = "$HOME/.config/hypr/hyprland-uwsm.conf";
    '';

    ".config/hypr/hyprland/uwsm-command-wrap.sh" = {
    executable = true;
    text = ''
 #! /usr/bin/env nix-shell
 #! nix-shell -i bash -p gawk coreutils

    configFile="$HOME/.config/hypr/hyprland.conf"
    outputFile="$HOME/.config/hypr/hyprland-uwsm.conf"
    tmpFile="$outputFile.tmp"

    if [ ! -s "$configFile" ]; then
      echo "Skipping wrapping because $configFile is empty or missing."
      exit 0
    fi

    awk '
    /^exec-once\s*=/ {
      sub(/^exec-once\s*=\s*/, "")
      cmd = $0
      if (cmd ~ /exit$/) {
        print "exec-once = uwsm stop"
      } else if (cmd !~ /[\/\.]|\.sh|\.py|bash|zsh/) {
        print "exec-once = uwsm --app " cmd
      } else {
        print "exec-once = " cmd
      }
      next
    }

    /^bind\s*=\s*.*exec,/ {
      split($0, parts, ",")
      cmd = parts[length(parts)]
      if (cmd == "exit") {
        parts[length(parts)] = "uwsm stop"
      } else if (cmd !~ /[\/\.]|\.sh|\.py|bash|zsh/) {
        parts[length(parts)] = "uwsm --app " cmd
      }
      out = parts[1]
      for (i = 2; i <= length(parts); ++i) {
        out = out "," parts[i]
      }
      print "bind = " out
      next
    }

    { print }
    ' "$configFile" > "$tmpFile"

    mv "$tmpFile" "$outputFile"
    '';
    };
  };

  activation.uwsmWrappingScript = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      verboseEcho "Running UWSM hyprland config wrapping..."
      run $HOME/.config/hypr/hyprland/uwsm-command-wrap.sh
      verboseEcho "UWSM wrapping applied."
    '';
  };
  };
}

