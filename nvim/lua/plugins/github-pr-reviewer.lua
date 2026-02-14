return {
  "otavioschwanck/github-pr-reviewer.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>pr", "<cmd>PR<cr>", desc = "PR Review Menu" },
    { "<leader>pl", "<cmd>PRListReviewRequests<cr>", desc = "PR List Review Requests" },
    { "<leader>ps", "<cmd>PRLoadLastSession<cr>", desc = "PR Load Last Session" },
    { "<leader>pi", "<cmd>PRInfo<cr>", desc = "PR Info" },
  },
  config = function()
    require("github-pr-reviewer").setup()
  end,
}