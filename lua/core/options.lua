-- lua/core/options.lua
-- Short descriptions added for each option

vim.g.loaded_netrw = 0 -- disable netrw file explorer
vim.g.loaded_netrwPlugin = 0 -- disable netrw plugin

local opt = vim.opt

opt.number = true -- show absolute line number for the current line
opt.relativenumber = true -- show relative line numbers for other lines
opt.tabstop = 2 -- number of spaces that a <Tab> counts for
opt.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
opt.softtabstop = 2 -- number of spaces a <Tab> uses while editing
opt.expandtab = true -- use spaces instead of tab characters
opt.smartindent = true -- enable smart auto-indenting for new lines
opt.termguicolors = true -- enable 24-bit RGB color in the terminal
opt.wrap = false -- disable line wrapping by default
opt.cursorline = true -- highlight the screen line with the cursor
opt.scrolloff = 8 -- keep at least 8 screen lines above and below the cursor
opt.signcolumn = "yes:2" -- always show sign column and reserve space for 2 signs
opt.mouse = "a" -- enable mouse support in all modes
opt.clipboard = "unnamedplus" -- use the system clipboard for yank/delete/put
opt.updatetime = 200 -- time in ms to wait before writing swap file and triggering CursorHold
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- override 'ignorecase' if search contains uppercase letters
opt.syntax = "on" -- enable syntax highlighting
opt.conceallevel = 3 -- conceal text (useful for markdown rendering)
opt.colorcolumn = "80" -- highlight column at 80 characters to mark line length
opt.laststatus = 3 -- global statusline (single statusline for all windows)
opt.undofile = true -- persist undo history to an undo file
opt.timeoutlen = 300 -- time in ms to wait for a mapped sequence to complete
opt.pumheight = 10 -- maximum number of items to show in the popup menu
opt.splitkeep = "screen" -- keep window view stable on split (options: 'screen', 'topline')

-- Folding
opt.foldmethod = "syntax" -- use syntax for folding (alternatives: "indent", "manual")
opt.foldlevel = 99 -- start with folds open (high value to avoid automatic folding)

-- Spellcheck
vim.cmd([[autocmd FileType markdown,text,html setlocal spell spelllang=en_us]]) -- enable spellcheck for common text filetypes

-- Enable line wrapping for markdown and text
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true -- enable wrapping in these filetypes
		vim.opt_local.linebreak = true -- wrap at word boundaries
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "codecompanion",
	callback = function()
		opt.number = false
		opt.relativenumber = false
	end,
})

-- Disable SQL complete omni
vim.g.loaded_sql_completion = 1 -- prevent loading built-in SQL completion
vim.g.omni_sql_no_default_maps = 1 -- disable default omni-completion mappings for SQL
