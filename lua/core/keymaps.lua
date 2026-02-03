-- lua/core/keymaps.lua
local map = vim.keymap.set

-- General
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Close all windows" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Close all windows (force)" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "L", "<cmd>Lazy<cr>", { desc = "Open Lazynvim" })
map("n", "M", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- Buffers
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprev<cr>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buffer" })

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

-- Running code/servers
map({ "n", "i" }, "<M-l>", function()
	require("betterTerm").send("python3 -m http.server 8000", 0, { clean = true })
	if os.execute("command -v browser-sync  > /dev/null") then
		require("betterTerm").send(
			"browser-sync start --no-online --server --host localhost:8000 --files '**/*.*'",
			1,
			{ clean = true }
		)
	end
end, { desc = "Python server at port 8000" })
