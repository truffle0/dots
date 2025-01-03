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

		view = {
			entries = "native",
		},

		-- keymaps defined later
		mapping = nil,

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

		-- set key mappings
		opts.mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		})

		-- highlight integration
		opts.formatting.format = require("nvim-highlight-colors").format

		-- Actual loading is done per-buffer on LspAttach
		-- this function mainly runs to properly initialize opts.
	end,
}
