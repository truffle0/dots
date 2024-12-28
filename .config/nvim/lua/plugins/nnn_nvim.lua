return {
	"luukvbaal/nnn.nvim",
	keys = {
		{ "<C-A-n>", "<cmd>NnnExplorer<CR>", mode = 't', desc = "Open nnn sidebar" },
		{ "<C-A-n>", "<cmd>NnnExplorer %:p:h<CR>", desc = "Open nnn sidebar" },
		{ "<C-A-p>", "<cmd>NnnPicker<CR>", mode = 't', desc = "Open nnn picker" },
		{ "<C-A-p>", "<cmd>NnnPicker<CR>", desc = "Open nnn picker" },
	},

	cmds = { "NnnExplorer", "NnnPicker" },

	dependencies = { "voldikss/vim-floaterm" },
	
	opts = {
		explorer = {
			cmd = "nnn -G",
			width = 24,
			tabs = false,
			fullscreen = false,
		}
	},

	env = {
		NNN_TRASH = "2",
	},

	config = function(PluginSpec, opts)
		local mod = require("nnn")
		
		-- inject keymaps before running setup
		local path = mod.builtin
		opts.mappings = {
			{ "<C-t>", path.open_in_tab },
			{ "<C-s>", path.open_in_split },
			{ "<C-S>", path.open_in_vsplit },
			{ "<C-p>", path.open_in_preview },
			{ "<C-y>", path.copy_to_clipboard },
			{ "<A-w>", path.cd_to_path },
			{ "<C-e>", path.populate_cmdline },
		}
		
		mod.setup(opts)

		-- export custom environment variables for nnn
		for k, v in pairs(PluginSpec.env) do
			vim.fn.setenv(k, v)
		end
	end,
}	
