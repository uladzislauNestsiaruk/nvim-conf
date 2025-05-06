return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "vimdoc", "c", "vim", "query", "cpp", "cmake", "python" },
			auto_install = true,
			highlight = {
				enabled = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Leader>ss",
					node_incremental = "<Leader>si",
					node_decremental = "<Leader>sd",
					scope_incremental = "<Leader>ssi",
				},
			},
		})
	end,
}
