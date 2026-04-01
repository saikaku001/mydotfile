return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    spec = {
      { "<leader>d",   group = "Debug" },
      { "<leader>go",  group = "Octo" },
      { "<leader>goc", group = "Comment" },
      { "<leader>gol", group = "Label" },
      { "<leader>goa", group = "Assignee" },
      { "<leader>gox", group = "Reaction" },
      { "<leader>got", group = "Thread" },
      { "<leader>goG", group = "Repo/Gist" },
    },
  },
}
