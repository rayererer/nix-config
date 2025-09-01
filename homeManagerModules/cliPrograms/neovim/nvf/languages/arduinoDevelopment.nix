{
  pkgs,
  lib,
  config,
  ...
}: let
  nvfCfg = config.my.cliPrograms.neovim.nvf;
  modCfg = nvfCfg.moduleCfg;
  cfg = modCfg.customPlugins.arduinoDevelopment;
in {
  options.my.cliPrograms.neovim.nvf = {
    moduleCfg.customPlugins = {
      arduinoDevelopment = {
        enable = lib.mkEnableOption ''
          Enable the arduino development custom plugin which makes development
          with arduino inside neovim way better.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings = {
      vim = {
        lazy.plugins = {
          "nvim-platformio-lua" = {
            package = pkgs.vimUtils.buildVimPlugin {
              name = "nvim-platformio-lua";
              pname = "nvim-platformio-lua";
              src = pkgs.fetchFromGitHub {
                owner = "anurag3301";
                repo = "nvim-platformio.lua";
                rev = "main";
                hash = "sha256-6rniPjzaUU7YQBSTl1WDyiw+w4kBG0P8SKJqrHvj5pw=";
              };

              # Testing if just skipping these are fine.
              # Which it very well might not.
              nvimSkipModules = [
                "minimal_config"
                "platformio.pioinit"
                "platformio.piolib"
              ];
            };

            # Lazy-load triggers
            lazy = true;
            ft = ["cpp" "dosini"]; # Arduino sketches and platformio.ini
            event = ["BufReadPost" "BufNewFile"];
            cmd = ["Piocmdf" "Piocmdh"]; # Commands provided by the plugin
            keys = [
              {
                key = "<leader>pb";
                mode = ["n"];
                action = ":Piocmdf run<CR>";
                desc = "PlatformIO: Build";
              }
              {
                key = "<leader>pu";
                mode = ["n"];
                action = ":Piocmdf run -t upload<CR>";
                desc = "PlatformIO: Upload";
              }
              {
                key = "<leader>pm";
                mode = ["n"];
                action = ":Piocmdh run -t monitor<CR>";
                desc = "PlatformIO: Monitor";
              }
              {
                key = "<leader>sm";
                mode = ["n"];
                action = ":terminal minicom -D $ARDUINO_PORT -b 115200<CR>";
                desc = "Quick Serial";
              }
            ];

            setupModule = "platformio";
            setupOpts = {
              lsp = "clangd";
              menu_key = "<leader>p";
            };

            after = ''
              vim.notify("PlatformIO plugin loaded", vim.log.levels.INFO)
            '';
          };
        };

        autocmds = [
          {
            event = ["BufRead" "BufNewFile"];
            pattern = ["*.ino"];
            command = "set filetype=cpp";
            desc = "Treat .ino files as C++";
          }
        ];
      };
    };
  };
}
