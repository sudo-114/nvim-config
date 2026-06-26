-- lua/core/keymaps.lua
local map = vim.keymap.set

local function close_buffer()
	local buf = vim.api.nvim_get_current_buf()

	-- Don't run this while inside Neo-tree
	if vim.bo[buf].filetype == "neo-tree" then
		return
	end

	-- Don't delete unsaved changes
	if vim.bo[buf].modified then
		vim.notify("Buffer has unsaved changes", vim.log.levels.WARN)
		return
	end

	-- Check whether Neo-tree is open
	local neo_tree_open = false

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local win_buf = vim.api.nvim_win_get_buf(win)

		if vim.bo[win_buf].filetype == "neo-tree" then
			neo_tree_open = true
			break
		end
	end

	-- Hide Neo-tree temporarily
	if neo_tree_open then
		vim.cmd("Neotree close")
	end

	-- Close the current buffer normally
	vim.cmd("bd")

	-- Bring Neo-tree back on the right
	if neo_tree_open then
		vim.cmd("Neotree filesystem show right")
	end
end

-- General
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Close all windows" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Close all windows (force)" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "L", "<cmd>Lazy<cr>", { desc = "Open Lazynvim" })
map("n", "M", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- Buffers
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprev<cr>", { desc = "Previous buffer" })

map("n", "<leader>bd", close_buffer, { desc = "Close buffer" })

--  Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go down window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go up window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go right window" })

-- Resizing window
map({ "n", "t" }, "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map({ "n", "t" }, "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map({ "n", "t" }, "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map({ "n", "t" }, "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("n", "<leader>=", "<C-w>=", { desc = "Balance window sizes" })

-- Splits
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Split below" })
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split right" })

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape active terminal" })
