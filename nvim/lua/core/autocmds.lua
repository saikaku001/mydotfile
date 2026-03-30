vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("TransparentBackground", { clear = true }),
  callback = function()
    vim.cmd([[
      highlight Normal guibg=none ctermbg=none
      highlight NonText guibg=none ctermbg=none
      highlight NormalNC guibg=none ctermbg=none
      highlight SignColumn guibg=none ctermbg=none
      highlight NormalFloat guibg=none ctermbg=none
      highlight FloatBorder guibg=none ctermbg=none
    ]])
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("StartupTime", { clear = true }),
  callback = function()
    -- lazy.nvim がロードされている場合のみ実行
    if package.loaded["lazy"] then
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      
      -- 起動時間を通知
      vim.notify("Neovim loaded in " .. ms .. "ms", vim.log.levels.INFO, {
        title = "Startup Time",
      })
    end
  end,
})
