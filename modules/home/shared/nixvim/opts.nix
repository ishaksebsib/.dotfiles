{ ... }:
{
  globals.mapleader = " ";

  opts = {
    clipboard = "unnamedplus";
    termguicolors = true;
    number = true;
    relativenumber = true;
    expandtab = false;
    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
    background = "dark";
  };

  diagnostics = {
    virtual_text = {
      source = "if_many";
      spacing = 4;
    };
    signs = true;
    underline = true;
    update_in_insert = false;
  };
}
