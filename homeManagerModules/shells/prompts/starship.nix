{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  shellCfg = config.my.shells;
  cfg = shellCfg.prompts.starship;
in {
  options.my.shells.prompts = {
    starship = {
      enable = lib.mkEnableOption "Enable the starship config module.";
    };
  };

  config = lib.mkIf cfg.enable {
    my.shells.prompts.prompts = ["starship"];

    programs = {
      starship = {
        enable = true;

        settings = {
          add_newline = false;

          # This is basically the pure preset:
          format = lib.concatStrings [
            "$username"
            "$hostname"
            "$directory"
            "$git_branch"
            "$git_state"
            "$git_status"
            "$cmd_duration"
            "$line_break"
            "$python"
            "$character"
          ];

          directory = {
            style = "blue";
          };

          character = {
            success_symbol = "[❯](purple)";
            error_symbol = "[❯](red)";
            vimcmd_symbol = "[❮](green)";
          };

          git_branch = {
            format = "[$branch]($style)";
            style = "bright-black";
          };

          git_status = {
            format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
            style = "cyan";
            conflicted = "​";
            untracked = "​";
            modified = "​";
            staged = "​";
            renamed = "​";
            deleted = "​";
            stashed = "≡";
          };

          git_state = {
            format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
            style = "bright-black";
          };

          cmd_duration = {
            format = "[$duration]($style) ";
            style = "yellow";
          };

          python = {
            format = "[$virtualenv]($style) ";
            style = "bright-black";
          };
        };
      };
    };
  };
}
