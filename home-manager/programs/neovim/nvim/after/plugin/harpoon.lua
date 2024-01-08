local harpoon = require("harpoon")
local extensions = require("harpoon.extensions")
harpoon:setup({
	--     settings = {
	--         save_on_toggle = true,
	--         sync_on_ui_close = true,
	--     },
})
-- harpoon:extend(extensions.builtins.navigate_with_number())
vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():append()
end)
vim.keymap.set("n", "<leader>hm", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-p>", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<C-n>", function()
	harpoon:list():next()
end)
