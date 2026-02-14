return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "github/copilot.vim" },    -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        opts = {
            debug = true, -- Enable debugging
            auto_insert_mode = false, -- 自動的にインサートモードに入らない
            show_help = true, -- ヘルプメッセージを表示
            question_header = "## User ", -- ユーザーのヘッダー
            answer_header = "## Copilot ", -- Copilotのヘッダー
            error_header = "## Error ", -- エラーのヘッダー
            
            -- プロンプト設定
            prompts = {
                Explain = {
                    prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
                },
                Review = {
                    prompt = "/COPILOT_REVIEW Review the selected code.",
                },
                Fix = {
                    prompt = "/COPILOT_FIX There is a problem in this code. Rewrite the code to show it with the bug fixed.",
                },
                Optimize = {
                    prompt = "/COPILOT_REFACTOR Optimize the selected code to improve performance and readability.",
                },
                Docs = {
                    prompt = "/COPILOT_DOCS Please add documentation comment for the selection.",
                },
                Tests = {
                    prompt = "/COPILOT_TESTS Please generate tests for my code.",
                },
                Commit = {
                    prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
                },
            },
            
            -- ウィンドウ設定
            window = {
                layout = "vertical", -- 'vertical', 'horizontal', 'float'
                width = 0.4, -- 画面幅の40%
                height = 0.6, -- 画面高さの60%
            },
        },
        keys = {
            {
                "<leader>cc",
                ":CopilotChatToggle<CR>",
                mode = { "n", "v" },
                desc = "Toggle Copilot Chat",
            },
            {
                "<leader>ce",
                ":CopilotChatExplain<CR>",
                mode = { "n", "v" },
                desc = "Copilot Chat Explain",
            },
            {
                "<leader>ct",
                ":CopilotChatTests<CR>",
                mode = { "n", "v" },
                desc = "Copilot Chat Tests",
            },
            {
                "<leader>cf",
                ":CopilotChatFix<CR>",
                mode = { "n", "v" },
                desc = "Copilot Chat Fix",
            },
            {
                "<leader>co",
                ":CopilotChatOptimize<CR>",
                mode = { "n", "v" },
                desc = "Copilot Chat Optimize",
            },
        },
    },
}