-- (for nvim-tree) disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("language en_US")


require "remap"
require "lazy-config"
require "set"
require "stacked"
