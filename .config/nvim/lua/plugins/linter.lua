return {
	"mfussenegger/nvim-lint",
	ft = { 'c', 'cpp' },

	-- was only really used for clang-tidy, clangd is enough on it's own
	enabled = false,
	
	opts = {
		linters_by_ft = {
			c = { 'clangtidy' },
			cpp = { 'clangtidy' },
		}
	},

	config = function(_, opts)
		local lint = require('lint')
		lint.linters_by_ft = opts.linters_by_ft
	
		-- only run linters in buffers with language servers
		vim.api.nvim_create_autocmd("LspAttach", { callback = function(args)
			vim.api.nvim_create_autocmd({"LspDetach", "BufWritePost"},
			{
				buffer = args.buf,
				callback = function(args)
					if args.event == "LspDetach" then 
						-- clean up callback if language server detaches
						return true
					end

					lint.try_lint()
				end
			})
		end})
	end
}
