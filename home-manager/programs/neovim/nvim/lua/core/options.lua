vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.mouse = "a"

vim.opt.laststatus = 3

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.swapfile = false

--vim.opt.cmdheight = 0
--
vim.api.nvim_create_autocmd({ "UiEnter", "ColorScheme" }, {
	callback = function()
		-- 1.
		vim.cmd([[
      hi TabLineFill gui=nocombine
      hi WinBar gui=nocombine
    ]])
		-- 2.
		vim.cmd([[
      hi TabLineFill guibg=none
      hi WinBar gui=none
    ]])
		-- 3.
		vim.cmd([[
      hi! link TabLineFill Normal
      hi! link WinBar Normal
    ]])
	end,
})
