{ ... }:
{
  keymaps = [
    # Move half page and center
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
    }
    # Window navigation
    {
      mode = "n";
      key = "gl";
      action = "<C-w>l";
      options.desc = "Window: Move right";
    }
    {
      mode = "n";
      key = "gh";
      action = "<C-w>h";
      options.desc = "Window: Move left";
    }
    # Copy relative file path
    {
      mode = "n";
      key = "<leader>y";
      action.__raw = ''
        function()
          local relative_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
          vim.fn.setreg("+", relative_path)
        end
      '';
      options.desc = "Copy relative path";
    }
    # Copy absolute file path
    {
      mode = "n";
      key = "<leader>Y";
      action.__raw = ''
        function()
          vim.fn.setreg("+", vim.fn.expand("%:p"))
        end
      '';
      options.desc = "Copy absolute path";
    }
  ];
}
