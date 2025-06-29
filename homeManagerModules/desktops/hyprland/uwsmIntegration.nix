{ pkgs, lib, config, ... }:

let
  origSettings = config.wayland.windowManager.hyrland.settings or {};
  traceSettings = builtins.trace origSettings "Tracing origSettings";
in
{
  options = {
    my.desktops.hyprland.moduleCfg.uwsmIntegration.enable = lib.mkEnableOption "Enable uwsmIntegration module that changes some settings and also wraps all needed commands.";
  };

  config = lib.mkIf config.my.desktops.hyprland.moduleCfg.uwsmIntegration.enable (let

    isScript = cmd:
      let
        lower = lib.strings.toLower cmd;
        hasShellPrefix = lib.any (p: lib.strings.hasPrefix p lower) [
          "/" "~" "bash " "sh " "zsh " "./"
        ];
        hasScriptSuffix = lib.any (s: lib.strings.hasSuffix s lower) [
          ".sh" ".bash" ".zsh" ".py" ".pl" ".rb"
        ];
        hasPath = lib.strings.hasInfix "/" lower;
      in hasShellPrefix || hasScriptSuffix || hasPath;

    wrapUwsm = cmd:
      "testing testing";
      # if cmd == "exit" then
        # "uwsm stop"
        # else if !isScript cmd then 
        # "uwsm --app ${cmd}"
      # else 
        # cmd;

    wrapExecOnceList = list: map wrapUwsm list;

    wrapBindList = list: map (
      line:
        if lib.strings.hasPrefix "exec," line then
          let parts = lib.strings.splitString "," line;
          in lib.concatStringsSep "," (
            lib.init parts ++ [ wrapUwsm (lib.last parts) ]
          )
        else line
    ) list;

  in {

    wayland.windowManager.hyprland = {
      systemd.enable = false;
    };

    home.file = {
      ".config/uwsm/env-hyprland".text = ''
        # This is to "regive" control of this env var,
        # which is needed to avoid warning if externally set before,
        # which is needed to make sure ly can actually start hyprland.
        export XDG_CURRENT_DESKTOP=Hyprland
      '';

      ".config/hypr/hyprland/uwsm-wrapped.conf".text = ''
        ${lib.concatStringsSep "\n" (map (cmd: "exec-once = ${cmd}") (wrapExecOnceList (traceSettings.exec-once or [])))}

        ${lib.concatStringsSep "\n" (wrapBindList (traceSettings.bind or []))}
      '';
    };
  });

}

