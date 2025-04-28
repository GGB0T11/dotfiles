return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local opts = { noremap = true, silent = true }

		vim.fn.sign_define("DapBreakpoint", {
			text = "",
			texthl = "DiagnosticSignError",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpointRejected", {
			text = "", -- or "❌"
			texthl = "DiagnosticSignError",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapStopped", {
			text = "", -- or "→"
			texthl = "DiagnosticSignWarn",
			linehl = "Visual",
			numhl = "DiagnosticSignWarn",
		})

		local function get_python()
			local venv = vim.fn.getcwd() .. "/.venv/bin/python"
			if vim.fn.filereadable(venv) == 1 then
				return venv
			end

			local env = os.getenv("VIRTUAL_ENV")
			if env then
				return env .. "/bin/python"
			end

			return "~/.debugpy_venv/bin/python"
		end

		require("dap-python").setup(get_python())

		dapui.setup({
			layouts = {
				{
					elements = { "scopes", "breakpoints" },
					position = "left",
					size = 40,
				},
				{
					elements = { "repl" },
					position = "bottom",
					size = 10,
				},
			},
		})

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		vim.keymap.set("n", "<Leader>dc", dap.continue, opts)
		vim.keymap.set("n", "<Leader>do", dap.step_over, opts)
		vim.keymap.set("n", "<Leader>di", dap.step_into, opts)
		vim.keymap.set("n", "<Leader>df", dap.step_out, opts)
		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, opts)
		vim.keymap.set("n", "<Leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, opts)
		vim.keymap.set("n", "<Leader>dr", dap.repl.open, opts)
		vim.keymap.set("n", "<Leader>dl", dap.run_last, opts)
		vim.keymap.set("n", "<Leader>dq", dap.terminate, opts)
		vim.keymap.set("n", "<Leader>du", dapui.toggle, opts)

		vim.api.nvim_create_user_command("DapPythonReload", function()
			require("dap-python").reload()
			print("Python Debugger reloaded! Current Python: " .. require("dap-python").python_path)
		end, {})
	end,
}
