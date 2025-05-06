return {
	--- Nerd tree and scheme ---
	require("plugins.nerdtree"),
	require("plugins.nerdtree_icons"),
	require("plugins.everforest"),

	--- Treesitter ---
	require("plugins.treesitter"),

	--- Formatters && Linters ---
	require("plugins.formatter"),
	require("plugins.linter"),

	--- automatic lsp installation ---
	require("plugins.mason"),
	require("plugins.mason-lspconfig"),
	require("plugins.lspconfig"),

	--- autocomplete ---
	require("plugins.autocomplete"),

	--- Another stuff ---
	require("plugins.noice"),
	require("plugins.git"),
	require("plugins.telescope"),
	require("plugins.airline"),
	require("plugins.autopairs"),
	require("plugins.which-key"),
}
