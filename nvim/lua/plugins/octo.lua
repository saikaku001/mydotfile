return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "Octo" },
  keys = {
    -- Issues
    { "<leader>goi",  "<cmd>Octo issue list<cr>",   desc = "Issue List" },
    { "<leader>goI",  "<cmd>Octo issue create<cr>", desc = "Issue Create" },
    { "<leader>goie", "<cmd>Octo issue edit<cr>",   desc = "Issue Edit" },
    { "<leader>goib", "<cmd>Octo issue browse<cr>", desc = "Issue Browse" },
    { "<leader>goic", "<cmd>Octo issue close<cr>",  desc = "Issue Close" },
    { "<leader>goir", "<cmd>Octo issue reopen<cr>", desc = "Issue Reopen" },
    { "<leader>goiR", "<cmd>Octo issue reload<cr>", desc = "Issue Reload" },
    { "<leader>gois", "<cmd>Octo issue search<cr>", desc = "Issue Search" },

    -- Pull Requests
    { "<leader>gop",  "<cmd>Octo pr list<cr>",     desc = "PR List" },
    { "<leader>goP",  "<cmd>Octo pr create<cr>",   desc = "PR Create" },
    { "<leader>gope", "<cmd>Octo pr edit<cr>",     desc = "PR Edit" },
    { "<leader>gopb", "<cmd>Octo pr browse<cr>",   desc = "PR Browse" },
    { "<leader>gopc", "<cmd>Octo pr close<cr>",    desc = "PR Close" },
    { "<leader>gopr", "<cmd>Octo pr reopen<cr>",   desc = "PR Reopen" },
    { "<leader>gopR", "<cmd>Octo pr reload<cr>",   desc = "PR Reload" },
    { "<leader>gops", "<cmd>Octo pr search<cr>",   desc = "PR Search" },
    { "<leader>gopk", "<cmd>Octo pr checkout<cr>", desc = "PR Checkout" },
    { "<leader>gopm", "<cmd>Octo pr merge<cr>",    desc = "PR Merge" },
    { "<leader>gopC", "<cmd>Octo pr commits<cr>",  desc = "PR Commits" },
    { "<leader>gopf", "<cmd>Octo pr changes<cr>",  desc = "PR Changes" },
    { "<leader>gopd", "<cmd>Octo pr diff<cr>",     desc = "PR Diff" },
    { "<leader>gopy", "<cmd>Octo pr ready<cr>",    desc = "PR Ready" },
    { "<leader>gopD", "<cmd>Octo pr draft<cr>",    desc = "PR Draft" },
    { "<leader>gopv", "<cmd>Octo reviewer add<cr>", desc = "PR Add Reviewer" },

    -- Reviews
    { "<leader>gor",  "<cmd>Octo review start<cr>",    desc = "Review Start" },
    { "<leader>goR",  "<cmd>Octo review submit<cr>",   desc = "Review Submit" },
    { "<leader>gore", "<cmd>Octo review resume<cr>",   desc = "Review Resume" },
    { "<leader>gorc", "<cmd>Octo review close<cr>",    desc = "Review Close" },
    { "<leader>gord", "<cmd>Octo review discard<cr>",  desc = "Review Discard" },
    { "<leader>gorC", "<cmd>Octo review comments<cr>", desc = "Review Comments" },

    -- Comments
    { "<leader>goca", "<cmd>Octo comment add<cr>",    desc = "Comment Add" },
    { "<leader>gocd", "<cmd>Octo comment delete<cr>", desc = "Comment Delete" },

    -- Labels
    { "<leader>gola", "<cmd>Octo label add<cr>",    desc = "Label Add" },
    { "<leader>golr", "<cmd>Octo label remove<cr>", desc = "Label Remove" },
    { "<leader>golc", "<cmd>Octo label create<cr>", desc = "Label Create" },

    -- Assignees
    { "<leader>goaa", "<cmd>Octo assignee add<cr>",    desc = "Assignee Add" },
    { "<leader>goar", "<cmd>Octo assignee remove<cr>", desc = "Assignee Remove" },

    -- Reactions
    { "<leader>gox+", "<cmd>Octo reaction thumbs_up<cr>",   desc = "React 👍" },
    { "<leader>gox-", "<cmd>Octo reaction thumbs_down<cr>", desc = "React 👎" },
    { "<leader>goxh", "<cmd>Octo reaction heart<cr>",       desc = "React ❤️" },
    { "<leader>goxr", "<cmd>Octo reaction rocket<cr>",      desc = "React 🚀" },
    { "<leader>goxe", "<cmd>Octo reaction eyes<cr>",        desc = "React 👀" },
    { "<leader>goxl", "<cmd>Octo reaction laugh<cr>",       desc = "React 😄" },
    { "<leader>goxH", "<cmd>Octo reaction hooray<cr>",      desc = "React 🎉" },
    { "<leader>goxc", "<cmd>Octo reaction confused<cr>",    desc = "React 😕" },

    -- Threads
    { "<leader>gotr", "<cmd>Octo thread resolve<cr>",   desc = "Thread Resolve" },
    { "<leader>gotu", "<cmd>Octo thread unresolve<cr>", desc = "Thread Unresolve" },

    -- Repo / Gist
    { "<leader>goGl", "<cmd>Octo repo list<cr>",  desc = "Repo List" },
    { "<leader>goGf", "<cmd>Octo repo fork<cr>",  desc = "Repo Fork" },
    { "<leader>goGv", "<cmd>Octo repo view<cr>",  desc = "Repo View" },
    { "<leader>goGg", "<cmd>Octo gist list<cr>",  desc = "Gist List" },

    -- Global
    { "<leader>gos", "<cmd>Octo search<cr>",  desc = "Search" },
    { "<leader>goA", "<cmd>Octo actions<cr>", desc = "Actions" },
  },
  opts = {
    picker = "snacks",
  },
}
