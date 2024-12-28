return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	
	init = function() vim.g.barbar_auto_setup = false end,
	opts = {
		animation = true,
	},

	keys = {
		-- Move to previous/next
		{ '<A-,>', '<Cmd>BufferPrevious<CR>', silent = true, noremap = true, desc = "Next Buffer" },
		{ '<A-.>', '<Cmd>BufferNext<CR>', silent = true, noremap = true, desc = "Previous Buffer" },

		-- Re-order to previous/next
		--{ '<A-<>', '<Cmd>BufferMovePrevious<CR>', silent = true, noremap = true, desc = "" },
		--{ '<A->>', '<Cmd>BufferMoveNext<CR>', silent = true, noremap = true, desc = "" },

		-- Goto buffer in position...
		{ '<A-1>', '<Cmd>BufferGoto 1<CR>', silent = true, noremap = true, desc = "Goto Buffer #1" },
		{ '<A-2>', '<Cmd>BufferGoto 2<CR>', silent = true, noremap = true, desc = "Goto Buffer #2" },
		{ '<A-3>', '<Cmd>BufferGoto 3<CR>', silent = true, noremap = true, desc = "Goto Buffer #3" },
		{ '<A-4>', '<Cmd>BufferGoto 4<CR>', silent = true, noremap = true, desc = "Goto Buffer #4" },
		{ '<A-5>', '<Cmd>BufferGoto 5<CR>', silent = true, noremap = true, desc = "Goto Buffer #5" },
		{ '<A-6>', '<Cmd>BufferGoto 6<CR>', silent = true, noremap = true, desc = "Goto Buffer #6" },
		{ '<A-7>', '<Cmd>BufferGoto 7<CR>', silent = true, noremap = true, desc = "Goto Buffer #7" },
		{ '<A-8>', '<Cmd>BufferGoto 8<CR>', silent = true, noremap = true, desc = "Goto Buffer #8" },
		{ '<A-9>', '<Cmd>BufferGoto 9<CR>', silent = true, noremap = true, desc = "Goto Buffer #9" },
		{ '<A-0>', '<Cmd>BufferLast<CR>', silent = true, noremap = true, desc = "Goto Last Buffer" },

		-- Pin/unpin buffer
		{ '<A-p>', '<Cmd>BufferPin<CR>', silent = true, noremap = true, desc = "Pin/Unpin Buffer" },

		-- Goto pinned/unpinned buffer
		--                 :BufferGotoPinned
		--                 :BufferGotoUnpinned

		-- Close buffer
		{ '<A-c>', '<Cmd>BufferClose<CR>', silent = true, noremap = true, desc = "Close Buffer" },

		-- Wipeout buffer
		--                 :BufferWipeout

		-- Close commands
		--                 :BufferCloseAllButCurrent
		--                 :BufferCloseAllButPinned
		--                 :BufferCloseAllButCurrentOrPinned
		--                 :BufferCloseBuffersLeft
		--                 :BufferCloseBuffersRight

		-- Magic buffer-picking mode
		{ '<C-p>',   '<Cmd>BufferPick<CR>', silent = true, noremap = true, desc = "Magic Buffer Pick " },
		{ '<C-s-p>', '<Cmd>BufferPickDelete<CR>', silent = true, noremap = true, desc = "Magic Buffer Delete" },

		-- Sort automatically by...
		--{ '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', silent = true, noremap = true, desc = "" },
		--{ '<Space>bn', '<Cmd>BufferOrderByName<CR>', silent = true, noremap = true, desc = "" },
		--{ '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', silent = true, noremap = true, desc = "" },
		--{ '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', silent = true, noremap = true, desc = "" },
		--{ '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', silent = true, noremap = true, desc = "" },
	}
}
