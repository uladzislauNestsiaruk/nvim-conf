return {
	"sainnhe/everforest",
	config = function()
		vim.g.everforest_background = "medium"
		vim.g.airline_theme = "everforest"
		vim.g.everforest_better_perfomance = true

		vim.cmd.colorscheme("everforest")
	end,
}
