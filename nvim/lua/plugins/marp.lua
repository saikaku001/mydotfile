return {
  "mpas/marp-nvim",
  keys = {
    { "<leader>mp", "<cmd>MarpToggle<cr>", desc = "Marp Toggle" },
    { "<leader>ms", "<cmd>MarpStatus<cr>", desc = "Marp Status" },
  },
  config = function()
    require("marp").setup({
      port = 8080,
      wait_for_response_timeout = 30,
      wait_for_response_delay = 1,
    })
  end,
}
