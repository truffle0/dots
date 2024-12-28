return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,

	opts = {
		options = {
			terminal_colors = true,
			transparent = true,
		}
	},

	init = function()
		vim.cmd("colorscheme carbonfox")
	end,
}
