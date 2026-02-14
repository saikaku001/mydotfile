return {
    {
        'stevearc/oil.nvim',
        dependencies = { "echasnovski/mini.icons" },
        lazy = false,

        opts = {
            default_file_explorer = true,
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            use_default_keymaps = false,
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, bufnr)
                    return name == ".." or name == ".git"
                end,
            },
        },
    }
}
