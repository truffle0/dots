-- Lazy (plugin loader) config
vim.g.mapleader = " "
require("lazy_init")

-- general settings
--vim.cmd("colorscheme carbonfox")

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.expandtab = true

-- default to insert in :terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "startinsert",
})
