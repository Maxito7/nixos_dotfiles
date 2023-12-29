require("core.options")
require("core.lazy")
require("core.ui")
require("core.keymaps")
require("nvim-web-devicons").set_icon({
	lua = {
		icon = "󰢱",
		color = "#7DCFFF",
		name = "Lua",
	},
})
local icon, color = require("nvim-web-devicons").get_icon_color("init.lua", "lua")
assert(icon == "󰢱")
assert(color == "#7DCFFF")
