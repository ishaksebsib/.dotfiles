{ ... }:
{
  plugins = {
    lsp = {
      enable = true;
      servers = {
        clangd.enable = true;
        cssls.enable = true;
        dockerls.enable = true;
        gopls.enable = true;
        html.enable = true;
        jsonls.enable = true;
        ts_ls.enable = true;
        pyright.enable = true;
        tailwindcss.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
          settings = {
            "rust-analyzer" = {
              cargo = {
                allFeatures = true;
              };
              procMacro = {
                enable = true;
              };
            };
          };
        };
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              diagnostics = {
                globals = [ "vim" ];
              };
              format = {
                enable = false;
              };
            };
          };
        };
      };
    };

    fidget = {
      enable = true;
      settings = {
        notification = {
          window = {
            winblend = 0;
          };
        };
      };
    };
  };

  extraConfigLua = ''
    local function YankDiagnosticError()
      vim.diagnostic.open_float()
      vim.diagnostic.open_float()
      local win_id = vim.fn.win_getid()
      vim.cmd("normal! j")
      vim.cmd("normal! VG")
      vim.cmd("normal! y")
      vim.api.nvim_win_close(win_id, true)
    end

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
    vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Find references" })
    vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope: Git Status" })
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Show current diagnostic in float" })
    vim.keymap.set("n", "<leader>gd", builtin.diagnostics, { noremap = true, silent = true, desc = "Open all diagnostics in telescope" })
    vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, { noremap = true, desc = "Code Actions" })
    vim.keymap.set({ "n", "v" }, "<leader>r", vim.lsp.buf.rename, { noremap = true, desc = "Rename All Same Variables" })
    vim.keymap.set("n", "yd", [[:lua YankDiagnosticError()<CR>]], { noremap = true, silent = true, desc = "Copy error" })
  '';
}
