return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- A list of servers to automatically install if they're not already installed.
        -- Example: { "lua_ls", "rust_analyzer", "html", "cssls" }
        ensure_installed = {},
      })
    end,
  },
}
