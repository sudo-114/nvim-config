return {

	-- Debugging
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			{ "igorlfs/nvim-dap-view", version = "1.*" },
		},
		config = function()
			local dap = require("dap")
			local dapvt = require("nvim-dap-virtual-text")
			local dapv = require("dap-view")

			-- Basic setups
			dapvt.setup({ enabled = true, show_stop_reason = true })
			dapv.setup({
				winbar = {
					sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "console", "repl" },
					default_section = "repl",
					controls = { enabled = true },
				},
				virtual_text = { enabled = false },
			})

			-- Better DAP signs (uses diagnostic highlight groups so colors match your theme)
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "", texthl = "DiagnosticSignHint", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapStopped",
				{ text = "", texthl = "DiagnosticSignInfo", linehl = "Visual", numhl = "" }
			)

			-- Auto open/close UI
			dap.listeners.before.attach.dapui_config = function()
				dapv.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapv.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapv.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapv.close()
			end

			local map = vim.keymap.set

			map("n", "<F5>", dap.continue, { desc = "DAP Continue" })
			map("n", "<F7>", "<cmd>:DapViewToggle<cr>", { desc = "Toggle DAP View" })
			map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
			map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
			map("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
			map("n", "<M-b>", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		end,
	},
}
