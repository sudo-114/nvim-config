-- lua/core/options.lua
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = false
opt.smartindent = true
opt.termguicolors = true
opt.wrap = false
opt.cursorline = true
opt.scrolloff = 8
opt.signcolumn = "yes:2"
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.updatetime = 200
opt.ignorecase = true
opt.smartcase = true
opt.syntax = "on"
opt.conceallevel = 3
opt.colorcolumn = "80"

-- Folding
opt.foldmethod = "syntax" -- Options: indent, syntax
opt.foldlevel = 99

-- Spellcheck
vim.cmd([[autocmd FileType markdown,text,html setlocal spell spelllang=en_us]])

-- Enable line wrapping for markdown and text
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true -- wrap at word boundaries
	end,
})

-- Disable SQL complete omni
vim.g.loaded_sql_completion = 1
vim.g.omni_sql_no_default_maps = 1
