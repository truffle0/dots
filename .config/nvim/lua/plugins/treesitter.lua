return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c", "lua", "vim", "vimdoc",
				"javascript", "html", "python",
				"rust", "haskell"
			},
			sync_install = false,
			highlight = { enabled = true },
			indent = { enabled = true },
		})
	end
}
