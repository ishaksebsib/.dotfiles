{ ... }:
{
  plugins.gitsigns = {
    enable = true;
    settings = { };
  };

  extraConfigLua = ''
    vim.keymap.set("n", "<leader>gih", "<cmd>lua require('gitsigns').preview_hunk()<CR>", { noremap = true, silent = true, desc = "Preview hunk" })
    vim.keymap.set("n", "<leader>gis", "<cmd>lua require('gitsigns').stage_hunk()<CR>", { noremap = true, silent = true, desc = "Stage hunk" })
    vim.keymap.set("n", "<leader>giu", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", { noremap = true, silent = true, desc = "Undo stage hunk" })
    vim.keymap.set("n", "<leader>gir", "<cmd>lua require('gitsigns').reset_hunk()<CR>", { noremap = true, silent = true, desc = "Reset hunk" })
    vim.keymap.set("n", "<leader>giR", "<cmd>lua require('gitsigns').reset_buffer()<CR>", { noremap = true, silent = true, desc = "Reset buffer" })
    vim.keymap.set("n", "<leader>gib", "<cmd>lua require('gitsigns').blame_line()<CR>", { noremap = true, silent = true, desc = "Blame line" })
    vim.keymap.set("n", "<leader>gid", "<cmd>lua require('gitsigns').diffthis()<CR>", { noremap = true, silent = true, desc = "Line diff" })
    vim.keymap.set("n", "<leader>gin", "<cmd>lua require('gitsigns').next_hunk()<CR>", { noremap = true, silent = true, desc = "Next hunk" })
    vim.keymap.set("n", "<leader>gip", "<cmd>lua require('gitsigns').prev_hunk()<CR>", { noremap = true, silent = true, desc = "Prev hunk" })
  '';
}
