return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			renderer = {
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "▶",
							arrow_open = "▼",
						},
					},
				},
			},
		})
	end,
}
