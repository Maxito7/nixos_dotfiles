local set = vim.opt_local
vim.bo.commentstring = "// %s"
vim.opt.conceallevel = 2
vim.g.typst_conceal = 1
vim.cmd([[setlocal wrap linebreak]])
set.spell = true
