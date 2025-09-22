-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Don't use relative line numbering
vim.opt.number = true
-- vim.opt.relativenumber = false

-- Don't do weird stuff with quotes and markdown
vim.opt.conceallevel = 0

-- Enable Python support
vim.g.lazyvim_python_lsp = "basedpyright"
