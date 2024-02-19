local NoNeckPain = require("no-neck-pain")
require("no-neck-pain").setup({
	width = 140,
	autocmds = {
		enableOnVimEnter = true,
		enableOnTabEnter = true,
	},
	buffers = {
		setNames = false,
		wo = {
			fillchars = "eob: ",
		},
		left = NoNeckPain.bufferOptions,
		right = NoNeckPain.bufferOptions,
	},
})

NoNeckPain.bufferOptions = {
	enabled = false,
	colors = NoNeckPain.bufferOptionsColors,
	--- @see NoNeckPain.bufferOptionsBo `:h NoNeckPain.bufferOptionsBo`
	bo = NoNeckPain.bufferOptionsBo,
	--- @see NoNeckPain.bufferOptionsWo `:h NoNeckPain.bufferOptionsWo`
	wo = NoNeckPain.bufferOptionsWo,
}

NoNeckPain.bufferOptionsWo = {
	--- @type boolean
	cursorline = false,
	--- @type boolean
	cursorcolumn = false,
	--- @type string
	colorcolumn = "0",
	--- @type boolean
	number = false,
	--- @type boolean
	relativenumber = false,
	--- @type boolean
	foldenable = false,
	--- @type boolean
	list = false,
	--- @type boolean
	wrap = true,
	--- @type boolean
	linebreak = true,
}

NoNeckPain.bufferOptionsBo = {
	--- @type string
	filetype = "no-neck-pain",
	--- @type string
	buftype = "nofile",
	--- @type string
	bufhidden = "hide",
	--- @type boolean
	buflisted = false,
	--- @type boolean
	swapfile = false,
}
