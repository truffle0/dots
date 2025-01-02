return {
	"hrsh7th/nvim-cmp",
	lazy = true,
	-- only setup to work with language servers, don't really want it all the time
	-- will be lazy-loaded per buffer when language servers attach

	dependencies = {
		-- "brenoprata10/nvim-highlight-colors",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		--"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"neovim/nvim-lspconfig",
	},

	opts = {
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'nvim_lsp_signature_help'},
			--{ name = 'buffer' },
			{ name = 'path'},
			{ name = 'luasnip' },
		},
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end
		},

		-- highlight integration, set dynamically during config
		formatting = {
			format = nil
		}
	},

	init = function(plugin)
		local opts = plugin.opts

		vim.api.nvim_create_autocmd("LspAttach", { callback = function(args)
			local caps = vim.lsp.get_client_by_id(args.data.client_id).server_capabilities

			-- load plugin for this buffer iff language server supports completion
			if caps.completionProvider then
				print("loading completion!")
				require("cmp").setup.buffer(opts)
			end
			
		end})
	end,

	config = function(_, opts)
		-- setup sources correctly
		opts.sources = require("cmp").config.sources(opts.sources)

		-- highlight integration
		opts.formatting.format = require("nvim-highlight-colors").format

		-- Actual loading is done per-buffer on LspAttach
		-- this function mainly runs to properly initialize opts.
	end,
}
