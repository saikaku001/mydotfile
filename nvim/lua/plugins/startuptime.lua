return {
  "dstein64/vim-startuptime",
  -- lazy-loading on command
  cmd = "StartupTime",
  -- init is called during startup. Configuration for vim-startuptime should be set here.
  init = function()
    vim.g.startuptime_tries = 10
  end,
}
