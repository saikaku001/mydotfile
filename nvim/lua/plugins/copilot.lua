return {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
        -- Optional: Configure copilot settings
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_tab_fallback = ""
        
        -- Optional: Set up keymaps
        vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
            expr = true,
            replace_keycodes = false,
            silent = true
        })
    end,
}