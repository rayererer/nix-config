{
  pkgs,
  lib,
  config,
  ...
}: {
  config = {
    programs.nvf.settings = {
      vim.options = {
        expandtab = true;
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
      };
    };
  };
}
