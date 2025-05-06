return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			cpp = { "cpplint" },
			c = { "cpplint" },
			cmake = { "cmakelint" },
			python = { "pylint" },
			lua = { "luacheck" },
		}

		local lint_autogroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			group = lint_autogroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
