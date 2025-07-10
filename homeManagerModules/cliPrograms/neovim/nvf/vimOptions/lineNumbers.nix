{ pkgs, lib, config, ... }:

{
config = {
  programs.nvf.settings = {
    vim.options = {
      
      number = true;
      relativenumber = true;
      numberwidth = 1;

      # To only have a sign column if anything in it.
      # Basically same as numberwidth=1 but for signcolumn.
      signcolumn = "auto";
    };
  };
};
}
