-- init.lua

-- 1. 基本設定の読み込み
require('core.options')
require('core.mappings')
require('core.autocmds')

-- 2. lazy.nvim の初期設定
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 3. lazy.nvim のセットアップ
require('lazy').setup(
    {
	spec = {
	    { import = "plugins" },
	},
        -- lazy.nvim のオプション (例: デバッグ、UIなど)
        change_detection = {
            notify = false, -- 設定変更時の通知をオフにする
        },
    }
)
