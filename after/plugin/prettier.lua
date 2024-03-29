local js_utils = require("js-helpers")
local null_ls = require("null-ls")
local prettier = require("prettier")

-- Based on the plugin readme:
-- https://github.com/MunifTanjim/prettier.nvim#setting-up-prettiernvim

if js_utils.is_prettier() then
  print("Using prettier!")

  null_ls.setup({
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })
      end

      if client.supports_method("textDocument/rangeFormatting") then
        vim.keymap.set("x", "<leader>f", function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })
      end
    end,
  })

  prettier.setup({
    bin = 'prettierd',
    filetypes = {
      "css",
      "graphql",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "less",
      "markdown",
      "scss",
      "typescript",
      "typescriptreact",
      "yaml",
    },
  })
end
