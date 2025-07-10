{
  pkgs,
  lib,
  config,
  ...
}: {
  config = {
    programs.nvf.settings = {
      vim.options = {
        scrolloff = 15;
      };
    };
  };
}
