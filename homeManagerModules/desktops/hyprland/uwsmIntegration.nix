{ pkgs, lib, config, ... }: 

let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.moduleCfg.uwsmIntegration;
  launcherCommand = if cfg.useApp2unit then
    "app2unit"
  else 
    "uwsm app --";
    
in
{
options.my.desktops.hyprland = {
  moduleCfg.uwsmIntegration = {
    enable = lib.mkEnableOption "Enable uwsmIntegration module that changes some settings and also wraps all needed commands.";
    useApp2unit = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Option to set if app2unit should be used as the app launcher, recommended because of its faster nature.";
    };
  };
};

config = lib.mkIf cfg.enable {

  wayland.windowManager.hyprland = {
    systemd.enable = false;
  };

  home.packages = lib.mkIf cfg.useApp2unit [
    pkgs.app2unit
  ];

  my.desktops.hyprland.envVars = [
    [ 
      "HYPRLAND_CONFIG"
      "${config.home.homeDirectory}/.config/hypr/hyprland-uwsm.conf"
      "Use UWSM config file, which is necessary for UWSM integration. (Will be deprecated and unnecessary soon hopefully (maybe not,since good solution is hard))."
    ]
  ] ++ lib.optional cfg.useApp2unit
    [
      "APP2UNIT_SLICES"
      "a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice"
      "Make app2unit a drop-in replacement for uwsm app launcher."
    ];

  home = { 

  file = {

    ".config/hypr/hyprland/uwsm-command-wrap.sh" = {
    executable = true;
    text = ''
#!/usr/bin/env nix-shell
#! nix-shell -i bash -p gawk coreutils

configFile="$HOME/.config/hypr/hyprland.conf"
outputFile="$HOME/.config/hypr/hyprland-uwsm.conf"
tmpFile="$outputFile.tmp"

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
  print "# (uwsm app -- appHere) (or app2unit) to ensure recommended start with uwsm."
  print "# -------------------------------------------------------------\n"
}
function ltrim(s)  { sub(/^[ \t\r\n]+/, "", s); return s }
function rtrim(s)  { sub(/[ \t\r\n]+$/, "", s); return s }
function trim(s)   { return rtrim(ltrim(s)) }

/^exec-once\s*=/ {
  line = $0
  sub(/^exec-once\s*=\s*/, "", line)
  split(line, parts, ",")

  cmd = trim(parts[length(parts)])
  # Wrap bare commands with the desired launch command.
  if (cmd !~ /^[\/\.]/ && cmd !~ /\.sh|\.py|bash|zsh/) {
    parts[length(parts)] = "${launcherCommand} " cmd
  }

  out = "bind=" parts[1]
  for (i = 2; i <= length(parts); ++i) {
    out = out "," parts[i]
  }
  print out
  next
}

/^bind\s*=\s*.*exec,/ {
  line = $0
  sub(/^bind\s*=\s*/, "", line)
  split(line, parts, ",")

  if (trim(parts[3]) != "exec") {
    print line
    next
  }

  cmd = trim(parts[length(parts)])
  # Wrap bare commands with the desired launch command.
  if (cmd !~ /^[\/\.]/ && cmd !~ /\.sh|\.py|bash|zsh/) {
    parts[length(parts)] = "${launcherCommand} " cmd
  }

  out = "bind=" parts[1]
  for (i = 2; i <= length(parts); ++i) {
    out = out "," parts[i]
  }
  print out
  next
}

/^bind\s*=\s*.*exit,/ {
  line = $0
  sub(/^bind\s*=\s*/, "", line)
  split(line, parts, ",")

  if (trim(parts[3]) != "exit") {
    print line
    next
  }

  parts[3] = "exec"
  parts[4] = "uwsm stop"

  out = "bind=" parts[1]
  for (i = 2; i <= length(parts); ++i) {
    out = out "," parts[i]
  }
  print out
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
