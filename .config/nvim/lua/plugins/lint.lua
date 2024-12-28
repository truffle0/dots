return {
	"mfussenegger/nvim-lint",
	ft = { "c" },
	config = function()
			require("lint").linters_by_ft = {
					c = { "clang-tidy" }
			}
	end,
}

