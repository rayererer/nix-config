{
  pkgs,
  lib,
  config,
  ...
}: {
  config = {
    programs.nvf.settings = {
      vim.diagnostics = {
        enable = true;

        config = {
          virtual_text = true;
        };
      };
    };
  };
}
