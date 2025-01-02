return {
	"lewis6991/hover.nvim",

	keys = {
		{ "K", nil, desc = "View hover info (hover.nvim)" },
		{ "gK", nil, desc = "Hover select (hover.nvim)" },
		{ "<C-p>", nil, desc = "Prevous source (hover.nvim)" },
		{ "<C-n>", nil, desc = "Next source (hover.nvim)" },
	},

	opts = {
		init = function()
			require("hover.providers.lsp")
		    -- require('hover.providers.gh')
			-- require('hover.providers.gh_user')
			-- require('hover.providers.jira')
			-- require('hover.providers.dap')
			-- require('hover.providers.fold_preview')
			-- require('hover.providers.diagnostic')
			require('hover.providers.man')
			-- require('hover.providers.dictionary')
		end,
		preview_opts = {
			border = "single",
		},
		preview_window = false,
		title = true,
		mouse_providers = { 'LSP' },
		mouse_delay = 1000
	},

	config = function(_, opts)
		local hover = require("hover")

		-- set keymaps
		vim.keymap.set("n", "K", hover.hover, { desc = "View hover info (hover.nvim)" })
		vim.keymap.set("n", "gK", hover.hover_select, { desc = "Hover select (hover.nvim)" })
		vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end, { desc = "Prevous source (hover.nvim)" })
		vim.keymap.set("n", "<C-n>", function()	require("hover").hover_switch("next") end, { desc = "Next source (hover.nvim)" })


		vim.keymap.set("n", "<MouseMove>", require('hover').hover_mouse, { desc = "Mouse (hover.nvim)" })
		vim.o.mousemoveevent = true

		require("hover").setup(opts)
	end,
}
