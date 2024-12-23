local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"AndreM222/copilot-lualine",
	},
}

function M.config()
	require("lualine").setup({
		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			ignore_focus = { "NvimTree" },
		},
		sections = {
			lualine_a = {},
			lualine_b = {
				{ "filename", path = 1 },
				"branch",
			},
			lualine_c = { "diagnostics" },
			lualine_x = { "copilot", "filetype" },
			lualine_y = { "selectioncount", "location" },
			lualine_z = { "searchcount", "progress" },
		},
		extensions = { "quickfix", "man", "fugitive" },
	})
end

return M
