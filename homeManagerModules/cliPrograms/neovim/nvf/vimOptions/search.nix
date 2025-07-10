{
  pkgs,
  lib,
  config,
  ...
}: {
  config = {
    programs.nvf.settings = {
      vim.options = {
        hlsearch = false;
      };
    };
  };
}
