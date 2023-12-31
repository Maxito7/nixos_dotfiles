local M = {}

function M.setup()
	local plugin = require("lualine")
	plugin.setup({
		options = {
			icons_enabled = true,
		},
	})
end

return M
