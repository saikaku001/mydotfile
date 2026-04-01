return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "Octo" },
  keys = {
    { "<leader>goi", "<cmd>Octo issue list<cr>", desc = "Octo Issue List" },
    { "<leader>goI", "<cmd>Octo issue create<cr>", desc = "Octo Issue Create" },
    { "<leader>gop", "<cmd>Octo pr list<cr>", desc = "Octo PR List" },
    { "<leader>goP", "<cmd>Octo pr create<cr>", desc = "Octo PR Create" },
    { "<leader>gor", "<cmd>Octo review start<cr>", desc = "Octo Review Start" },
    { "<leader>goR", "<cmd>Octo review submit<cr>", desc = "Octo Review Submit" },
  },
  opts = {
    picker = "snacks",
  },
}
