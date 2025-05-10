local keymap = vim.keymap.set

vim.g.mapleader = " "

--- NERD tree ---
keymap("n", "<Leader>e", ":NvimTreeToggle<cr>", { noremap = true, desc = "toggle nvim tree" })

--- Telescope ---
function telescope_keymaps()
	local telescope_builtin = require("telescope.builtin")

	keymap("n", "<Leader>ff", telescope_builtin.find_files, { desc = "Telescope find files" })
	keymap("n", "<Leader>fg", telescope_builtin.live_grep, { desc = "Telescope live grep" })
	keymap("n", "<Leader>fb", telescope_builtin.buffers, { desc = "Telescope buffers" })
	keymap("n", "<Leader>fh", telescope_builtin.help_tags, { desc = "Telescope help tags" })
end

--- Format ---
function format_keymaps()
	local format = require("conform")
	keymap({ "n", "v" }, "<Leader>df", function()
		format.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		}, { desc = "format selected or file" })
	end)
end

--- LSP ---
keymap("n", "<Leader>gd", function()
	local current_uri = vim.uri_from_bufnr(0)

	vim.lsp.buf_request(0, "textDocument/definition", vim.lsp.util.make_position_params(), function(_, result)
		if not result or vim.tbl_isempty(result) then
			return
		end

		local target_uri = result[1].uri or result[1].targetUri
		if current_uri == target_uri then
			vim.lsp.util.jump_to_location(result[1])
		else
			vim.cmd("tab split")
			vim.lsp.util.jump_to_location(result[1])
		end
	end)
end, { noremap = true, silent = true, desc = "Go to definition" })
keymap("n", "<Leader>ca", "<cmd> lua vim.lsp.buf.code_action()<cr>", { noremap = true, desc = "do complition" })
keymap("n", "<Leader>sh", "<cmd> lua vim.lsp.buf.hover()<cr>", { noremap = true, desc = "show code descrition" })

--- Tabs ---
keymap("n", "<Leader>to", "<cmd>tabnew<cr>", { desc = "open new tab" })
keymap("n", "<Leader>tc", "<cmd>tabclose<cr>", { desc = "closes current tab" })
keymap("n", "<Leader>tl", "<cmd>tabnext<cr>", { desc = "go to the next tab" })
keymap("n", "<Leader>th", "<cmd>-tabnext<cr>", { desc = "go to the previous tab" })
keymap("n", "<Leader>tml", "<cmd>+tabmove<cr>", { desc = "move tab to the right" })
keymap("n", "<Leader>tmh", "<cmd>-tabmove<cr>", { desc = "move tab to the left" })

--- Screen split ---
keymap("n", "<Leader>sv", "<cmd>vsplit<cr>", { desc = "split vertically" })
keymap("n", "<Leader>sh", "<cmd>split<cr>", { desc = "split horizontally" })
keymap("n", "<Leader>sx", "<cmd>close<cr>", { desc = "close splited part" })

keymap("n", "<C-h>", "<C-w>h", { desc = "move to the left split" })
keymap("n", "<C-j>", "<C-w>j", { desc = "move to the down split" })
keymap("n", "<C-k>", "<C-w>k", { desc = "move to the up split" })
keymap("n", "<C-l>", "<C-w>l", { desc = "move to the right split" })
