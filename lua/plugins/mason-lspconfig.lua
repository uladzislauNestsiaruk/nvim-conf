return {
	dependencies = {
		"mason.nvim",
		"nvim-lspconfig",
		"cmp-nvim-lsp",
	},

	"williamboman/mason-lspconfig.nvim",

	config = function()
		vim.diagnostic.config({
			virtual_text = false,
		})
		vim.o.updatetime = 250
		vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
		local autocomplete_capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("mason-lspconfig").setup({
			ensure_installed = { "clangd", "pyre", "cmake" },
		})

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = autocomplete_capabilities,
				})
			end,

			require("lspconfig").clangd.setup({
				capabilities = autocomplete_capabilities,
				cmd = {
					"clangd",
					"--background-index",
					"--compile-commands-dir=" .. vim.fn.getcwd(),
					"--log=error",
					"--all-scopes-completion",
					"--query-driver=clang++",
					"--enable-config",
					"--fallback-style=file",
					"--header-insertion=never",
					"--limit-results=100",
					"-pch-storage=memory",
				},
				init_options = {
					memoryLimit = 8192,
					clangdFileStatus = true,
					fallbackFlags = {
						"-stdc++=20",
					},
				},
			}),
		})
	end,
}
