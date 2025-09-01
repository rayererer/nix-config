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
            cmd = [
              "PioTermList"
              "Piocmdf"
              "Piocmdh"
              "Piodb"
              "Piodebug"
              "Pioinit"
              "Piolib"
              "Piomon"
              "Piorun"
            ]; # Commands provided by the plugin

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

            load = ''
              -- local platformioRootDir = vim.fs.root(vim.fn.getcwd(), { 'platformio.ini' }) -- cwd and parents
              local platformioRootDir = (vim.fn.filereadable('platformio.ini') == 1) and vim.fn.getcwd() or nil
              if platformioRootDir and vim.fs.find('.pio', { path = platformioRootDir, type = 'directory' })[1] then
                -- if platformio.ini file and .pio folder exist in cwd, enable plugin to install plugin (if not istalled) and load it.
                vim.g.platformioRootDir = platformioRootDir
              elseif (vim.uv or vim.loop).fs_stat(vim.fn.stdpath('data') .. '/lazy/nvim-platformio.lua') == nil then
                -- if nvim-platformio not installed, enable plugin to install it first time
                vim.g.platformioRootDir = vim.fn.getcwd()
              else                                                     -- if nvim-platformio.lua installed but disabled, create Pioinit command
                vim.api.nvim_create_user_command('Pioinit', function() --available only if no platformio.ini and .pio in cwd
                  vim.api.nvim_create_autocmd('User', {
                    pattern = { 'LazyRestore', 'LazyLoad' },
                    once = true,
                    callback = function(args)
                      if args.match == 'LazyRestore' then
                        require('lazy').load({ plugins = { 'nvim-platformio.lua' } })
                      elseif args.match == 'LazyLoad' then
                        vim.notify('PlatformIO loaded', vim.log.levels.INFO, { title = 'PlatformIO' })
                        vim.cmd('Pioinit')
                      end
                    end,
                  })
                  vim.g.platformioRootDir = vim.fn.getcwd()
                  require('lazy').restore({ plguins = { 'nvim-platformio.lua' }, show = false })
                end, {})
              end
              return vim.g.platformioRootDir ~= nil
            '';

            setupModule = "platformio";
            setupOpts = {
              lsp = "clangd";
              menu_key = "<leader>p";
            };
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
