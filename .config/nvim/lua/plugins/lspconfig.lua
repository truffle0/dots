return {
	"neovim/nvim-lspconfig",

	config = function()
		lsp = require("lspconfig")

		local map = function(t, k, v)
			vim.fn.nvim_buf_set_keymap(0, t, k, v, {noremap = true, silent = true})
		end

		local bind_buffer = function(client)
			map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
			map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
			map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
			map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
			map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
			map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
			map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
		end

		-- SERVERS --
		lsp.hls.setup{
				filetypes = { 'haskell', 'lhaskell', 'cabal' },
				on_attach = bind_buffer,
		}
		
		lsp.rust_analyzer.setup{
			settings = {
				['rust-analyzer'] = {
					diagnostics = { enabled = true },
				}
			},
			on_attach = bind_buffer,
		}

		lsp.ruff.setup{
			on_attach = bind_buffer,
		}

		lsp.clangd.setup{
			on_attach = bind_buffer,
		}
	end,
}
