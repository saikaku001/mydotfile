vim.g.mapleader = " "
vim.g.startup_cwd = vim.fn.getcwd()
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorcolumn = true

vim.opt.termguicolors = true
vim.opt.winblend = 10 -- ウィンドウの不透明度
vim.opt.pumblend = 10 -- ポップアップメニューの不透明度
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.o.clipboard = "unnamedplus"

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

-- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4

-- 背景透過設定 (エディタ全体の背景をターミナル背景に合わせる)
vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]])
