return {
	"https://github.com/stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				cpp = { "clang-format" },
				c = { "clang-format" },
				python = { "autoflake", "black" },
				cmake = { "gersemi" },
				lua = { "stylua" },
				bash = { "beautysh" },
				zsh = { "beautysh" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		format_keymaps()
	end,
}
