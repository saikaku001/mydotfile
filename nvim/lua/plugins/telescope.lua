return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        require('telescope').setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                },
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            },
            defaults = {
                -- デフォルト設定
                file_ignore_patterns = { "node_modules", ".git/" },
                layout_config = {
                    horizontal = {
                        preview_width = 0.55,
                    },
                },
            }
        })
        require("telescope").load_extension("ui-select")
        require('telescope').load_extension('fzf')
    end
}
