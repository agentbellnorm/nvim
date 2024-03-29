local lspconfig = require("lspconfig")
local js_utils = require("js-helpers")

if js_utils.is_eslint() then
  print("using eslint!")

  lspconfig.eslint.setup({
    settings = {
      packageManager = 'npm'
    },
    on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set("n", "<leader>f", vim.cmd.EslintFixAll, opts)
      vim.keymap.set("x", "<leader>f", vim.cmd.EslintFixAll, opts)
    end,
  })
end
