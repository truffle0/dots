return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter").setup{
			highlight = { enabled = true },
		}

		require("nvim-treesitter.configs").setup{
			ensure_installed = {
				"c", "lua", "vim", "vimdoc",
				"javascript", "html", "python",
				"rust", "haskell"
			},
			sync_install = false,
			highlight = { enabled = true },
			indent = { enabled = true },
		}
	end
}
