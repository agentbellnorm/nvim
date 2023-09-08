local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup('plugins')

require("telescope").setup()

require("Comment").setup({
    toggler = {
        line = '<leader>c',
        -- block = '<leader>bc',
    },
    opleader = {
        line = '<leader>c',
        -- block = '<leader>bc', -- slows down <leader>b for backing
    },
})

require'lspconfig'.lua_ls.setup{}

require('gitsigns').setup()
