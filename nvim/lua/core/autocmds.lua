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
