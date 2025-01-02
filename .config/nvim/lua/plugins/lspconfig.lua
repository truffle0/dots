return {
	"neovim/nvim-lspconfig",
	
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},

	opts = {
		servers = {
			hls = {
				filetypes = { 'haskell', 'lhaskell', 'cabal' },
			},
			clangd = {},
			rust_analyzer = {
				settings = {
					['rust-analyzer'] = {
						diagnostics = { enabled = true },
					}
				},
			},
			ruff = {},
			
			-- vscode-langservers-extracted
			cssls = {},
			eslint = {},
			html = {},
			jsonls = {},
		},
	},

	config = function(_, opts)
		lsp = require("lspconfig")
		
		-- alias for the more long-winded mapping function
		local map = function(keys, func, description)
			vim.api.nvim_buf_set_keymap(0, 'n', keys, '', {
				callback = func,
				desc = description,
				silent = true, noremap = true,
			})
		end

		-- create keybinds on LSP buffer attach
		local bind_buffer = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local cap = client.server_capabilities
			local bufnr = args.buf

			-- info and goto commands
			if cap.declarationProvider then
				map('gD', vim.lsp.buf.declaration, "Go to declaration (LSP)")
			end
			
			if cap.definitionProvider then
				map('gd', vim.lsp.buf.definition, "Go to definition (LSP)")
			end
			
			if cap.hoverProvider and not require("hover") then
				-- running require("hover") checks for (and starts) the hover plugin
				-- keymap below is a fallback
				map('K', vim.lsp.buf.hover, "Show hover info (LSP)")
			end

			if cap.referencesProvider then
				map('gr', vim.lsp.buf.references, "Show references (LSP)")
			end

			if cap.signatureHelpProvider then
				map('gs', vim.lsp.buf.signature_help, "Signature help (LSP)")
			end

			if cap.implementationProvider then
				map('gi', vim.lsp.buf.implementation, "Show implementation (LSP)")
			end
			
			if cap.typeDefinitionProvider then
				map('gt', vim.lsp.buf.type_definition, "Type definition (LSP)")
			end

			-- autocomplete and formatting
			-- complete is configured in the nvim-cmp plugin spec

			if cap.documentFormattingProvider then
				vim.api.nvim_buf_create_user_command(0, "Format", vim.lsp.buf.format, { desc = "Trigger code formatting (LSP)" })
			end

			-- inlay hints
			if vim.lsp.inlay_hint and cap.inlayHintProvider then
				-- disable then enable to force refresh on attach
				vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end

			-- highlight support
			if cap.documentHighlightProvider and require("nvim-highlight-colors") then
				require("nvim-highlight-colors").turnOn()
			end

		end
		
		-- setup when server attaches to a buffer
		vim.api.nvim_create_autocmd('LspAttach', { callback = bind_buffer })
		
		for server, args in pairs(opts.servers) do
			-- advertise nvim-cmp supported completion types (if available), and merge with args
			if require("cmp_nvim_lsp") then
				args = vim.tbl_deep_extend('keep', args, require("cmp_nvim_lsp").default_capabilities())
			end

			lsp[server].setup(args)
		end
	end,
}
