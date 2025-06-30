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
      # which is needed to make sure ly can actually start hyprland with Ly.
      export XDG_CURRENT_DESKTOP=Hyprland

      # This is to make sure uwsm config file is used,
      # which is necessary if the wrapping of e.g. binds should work.
      export HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland-uwsm.conf"
    '';

    # This script takes all binds that are for apps and wraps them in their appropriate
    # uwsm start way. It also takes exec-once and throws all of them in to a uwsm start file instead.
    ".config/hypr/hyprland/uwsm-command-wrap.sh" = {
    executable = true;
    text = ''
#!/usr/bin/env nix-shell
#! nix-shell -i bash -p gawk coreutils

configFile="$HOME/.config/hypr/hyprland.conf"
outputFile="$HOME/.config/hypr/hyprland-uwsm.conf"
tmpFile="$outputFile.tmp"
uwsmStartFile="$HOME/.config/uwsm/start"

# Skip if config missing or empty
if [ ! -s "$configFile" ]; then
  echo "Skipping wrapping because $configFile is empty or missing."
  exit 0
fi

# Clear uwsm start file for fresh app list
: > "$uwsmStartFile"

# Temp file to store collected apps
appsTmpFile="$(mktemp)"

awk -v appsTmpFile="$appsTmpFile" '
BEGIN {
  print "# -------------------------------------------------------------"
  print "# This config has been wrapped by a script to put all exec-once commands in the"
  print "# uwsm start file (~/.config/uwsm/start) and to wrap all binds to apps with"
  print "# (uwsm app -- appHere) to ensure recommended start with uwsm."
  print "# -------------------------------------------------------------\n"
}
function ltrim(s)  { sub(/^[ \t\r\n]+/, "", s); return s }
function rtrim(s)  { sub(/[ \t\r\n]+$/, "", s); return s }
function trim(s)   { return rtrim(ltrim(s)) }

/^exec-once\s*=/ {
  sub(/^exec-once\s*=\s*/, "")
  cmd = trim($0)

  # Collect the app for uwsm start
  print cmd >> appsTmpFile

  # Remove this line from output by skipping print
  next
}

/^bind\s*=\s*.*exec,/ {
  line = $0
  sub(/^bind\s*=\s*/, "", line)
  split(line, parts, ",")

  cmd = trim(parts[length(parts)])
  # Wrap bare commands with uwsm app --
  if (cmd !~ /^[\/\.]/ && cmd !~ /\.sh|\.py|bash|zsh/) {
    parts[length(parts)] = "uwsm app -- " cmd
  }

  out = "bind = " parts[1]
  for (i = 2; i <= length(parts); ++i) {
    out = out "," parts[i]
  }
  print out
  next
}

{ print }
' "$configFile" > "$tmpFile"

# Deduplicate and append collected apps to uwsm start file
sort -u "$appsTmpFile" >> "$uwsmStartFile"
rm "$appsTmpFile"

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
