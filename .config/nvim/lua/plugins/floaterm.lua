return {
	'voldikss/vim-floaterm',
	cmd = {
		"FloatermNew", "FloatermPrev", "FloatermNext", "FloatermFirst",
		"FloatermLast", "FloatermUpdate", "FloatermToggle", "FloatermShow",
		"FlotermHide", "FloattermKill", "FloatermSend",
	},
	keys = {
		{ "<F7>", "<cmd>FloatermToggle<CR>", desc = "Show/Hide Floating Terminal" },
		{ "<F7>", "<cmd>FloatermToggle<CR>", mode = 't', desc = "Show/Hide Floating Terminal" },
	},
}
