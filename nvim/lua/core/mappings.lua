local map = function(mode, lhs, rhs, desc)
  local opts = { noremap = true, silent = true, desc = desc }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- jk でインサートモードを抜ける
map('i', '<leader>jk', '<ESC>', 'Exit insert mode')

-- 検索ハイライトを消す (Leader + h)
map('n', '<leader>h', ':nohlsearch<CR>', 'Clear search highlights')

-- ファイル保存 (Leader + w)
map('n', '<leader>s', ':w<CR>', 'Save file')

-- ウィンドウ間の移動（Ctrl + H/J/K/L）
map('n', '<C-h>', '<C-w>h', 'Move to left window')
map('n', '<C-j>', '<C-w>j', 'Move to lower window')
map('n', '<C-k>', '<C-w>k', 'Move to upper window')
map('n', '<C-l>', '<C-w>l', 'Move to right window')

-- 画面分割
map('n', '<leader>ww', ':vsplit<CR>', 'Vertical split')
map('n', '<leader>wt', ':split<CR>', 'Horizontal split')

-- ウィンドウサイズ変更（Ctrl + 矢印キー）
map('n', '<C-Up>', ':resize +2<CR>', 'Increase window height')
map('n', '<C-Down>', ':resize -2<CR>', 'Decrease window height')
map('n', '<C-Left>', ':vertical resize -2<CR>', 'Decrease window width')
map('n', '<C-Right>', ':vertical resize +2<CR>', 'Increase window width')

-- バッファの移動 (Shift + h/l, Tab)
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', 'Previous buffer')
map('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', 'Next buffer')
map('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', 'Next buffer')
map('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', 'Previous buffer')

-- タブの移動 (Leader + tn/tp)
map('n', '<leader>tn', '<cmd>tabnext<CR>', 'Next tab')
map('n', '<leader>tp', '<cmd>tabprevious<CR>', 'Previous tab')

-- バッファを閉じる (Leader + c)
map('n', '<leader>c', ':bdelete<CR>', 'Close buffer')

-- 他のバッファをすべて閉じる (Leader + bo)
map('n', '<leader>bo', function()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) and vim.fn.buflisted(buf) == 1 then
      pcall(vim.api.nvim_buf_delete, buf, {})
    end
  end
end, 'Close all other buffers')

-- 全終了 (Leader + q)
map('n', '<leader>qa', ':qa!<CR>', 'Quit all')
map('n', '<leader>qq', ':q!<CR>', 'Quit current window')
map('n', '<leader>wqa', ':wqa!<CR>', 'Quit all')
map('n', '<leader>wqq', ':wq!<CR>', 'Quit current window')

-- 選択範囲をインデント（< や >）する際、選択範囲を維持する
map('v', '<', '<gv', 'Indent left')
map('v', '>', '>gv', 'Indent right')

-- ビジュアルモードで行を移動 (J/K)
map("v", "J", ":m '>+1<CR>gv=gv", 'Move line down')
map("v", "K", ":m '<-2<CR>gv=gv", 'Move line up')

-- クリップボード操作 (Leader + y/p)
-- システムクリップボードへのコピー
map({ 'n', 'v' }, '<leader>y', '"+y', 'Copy to system clipboard')
-- システムクリップボードからのペースト
map({ 'n', 'v' }, '<leader>p', '"+p', 'Paste from system clipboard')

-- x で文字を削除したときにレジスタに入れない
map('n', 'x', '"_x', 'Delete char without yank')

-- ToggleTerm
-- ターミナルの開閉 (Ctrl + \)
map({ 'n', 't' }, '<C-t>', '<cmd>ToggleTerm<CR>', 'Toggle terminal')

-- ターミナルを Vim の起動パス (CWD) で開く (Leader + tv)
map('n', '<leader>tv', function()
  local count = 1
  require("toggleterm").toggle(count, nil, vim.g.startup_cwd, "float")
end, 'Toggle terminal (root dir)')

-- ターミナルを現在のファイルのディレクトリで開く (Leader + tf)
map('n', '<leader>tf', function()
  local count = 2
  local dir = vim.fn.expand("%:p:h")
  if dir == "" then
    dir = vim.fn.getcwd()
  end
  if dir:match("^oil://") then
    dir = dir:gsub("^oil://", "")
  end
  require("toggleterm").toggle(count, nil, dir, "float")
end, 'Toggle terminal (current dir)')

-- ターミナルモードでの操作
-- Esc または jk でターミナルモードから抜ける
map('t', '<esc>', [[<C-\><C-n>]], 'Exit terminal mode')
map('t', '<leader>jk', [[<C-\><C-n>]], 'Exit terminal mode')

-- ターミナルウィンドウ間の移動
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], 'Move to left window')
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], 'Move to lower window')
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], 'Move to upper window')
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], 'Move to right window')

-- Snacks: notifier
-- 通知履歴を表示 (Leader + nh)
map('n', '<leader>nh', function() Snacks.notifier.show_history() end, 'Notification History')
-- 全通知を閉じる (Leader + un)
map('n', '<leader>un', function() Snacks.notifier.hide() end, 'Dismiss All Notifications')

-- Snacks: bufdelete
-- バッファを削除 (Leader + bd)
map('n', '<leader>bd', function() Snacks.bufdelete() end, 'Delete Buffer')

-- Snacks: lazygit
-- Lazygit を開く (Leader + gg)
map('n', '<leader>gg', function() Snacks.lazygit() end, 'Lazygit')
-- 現在のファイルの Git 履歴 (Leader + gf)
map('n', '<leader>gf', function() Snacks.lazygit.log_file() end, 'Lazygit Current File History')
-- Git ログ (Leader + gl)
map('n', '<leader>gl', function() Snacks.lazygit.log() end, 'Lazygit Log (CWD)')

-- Snacks: gitbrowse
-- ブラウザで Git リポジトリを開く (Leader + gb)
map({ 'n', 'v' }, '<leader>gb', function() Snacks.gitbrowse() end, 'Git Browse')

-- Snacks: rename
-- ファイルをリネーム (Leader + cR)
map('n', '<leader>cR', function() Snacks.rename.rename_file() end, 'Rename File')

-- Snacks: zen
-- Zen モードの切り替え (Leader + z)
map('n', '<leader>z', function() Snacks.zen() end, 'Toggle Zen Mode')
-- ズームの切り替え (Leader + Z)
map('n', '<leader>Z', function() Snacks.zen.zoom() end, 'Toggle Zoom')

-- Snacks: scratch
-- スクラッチバッファの切り替え (Leader + .)
map('n', '<leader>.', function() Snacks.scratch() end, 'Toggle Scratch Buffer')
-- スクラッチバッファを選択 (Leader + S)
map('n', '<leader>S', function() Snacks.scratch.select() end, 'Select Scratch Buffer')

-- Snacks: words
-- 次のリファレンスへ (]])
map({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, 'Next Reference')
-- 前のリファレンスへ ([[)
map({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, 'Prev Reference')

-- Snacks: toggle (VeryLazy 後に設定)
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- スペルチェックの切り替え (Leader + us)
    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
    -- 折り返しの切り替え (Leader + uw)
    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
    -- 相対行番号の切り替え (Leader + uL)
    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    -- 診断の切り替え (Leader + ud)
    Snacks.toggle.diagnostics():map("<leader>ud")
    -- 行番号の切り替え (Leader + ul)
    Snacks.toggle.line_number():map("<leader>ul")
    -- conceallevel の切り替え (Leader + uc)
    Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
    -- Treesitter の切り替え (Leader + uT)
    Snacks.toggle.treesitter():map("<leader>uT")
    -- 背景色の切り替え (Leader + ub)
    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
    -- インレイヒントの切り替え (Leader + uh)
    Snacks.toggle.inlay_hints():map("<leader>uh")
    -- インデントガイドの切り替え (Leader + ug)
    Snacks.toggle.indent():map("<leader>ug")
    -- Dim モードの切り替え (Leader + uD)
    Snacks.toggle.dim():map("<leader>uD")
  end,
})

-- Snacks.picker
-- ファイル検索 (Leader + ff)
map('n', '<leader>ff', function() Snacks.picker.files() end, 'Find files')
-- 文字列検索 (Leader + fg)
map('n', '<leader>fg', function() Snacks.picker.grep() end, 'Live grep')
-- バッファ検索 (Leader + fb)
map('n', '<leader>fb', function() Snacks.picker.buffers() end, 'Find buffers')
-- ヘルプ検索 (Leader + fh)
map('n', '<leader>fh', function() Snacks.picker.help() end, 'Help tags')
-- 最近開いたファイル (Leader + fr)
map('n', '<leader>fr', function() Snacks.picker.recent() end, 'Recent files')
-- Gitファイル検索 (Leader + fgf)
map('n', '<leader>fgf', function() Snacks.picker.git_files() end, 'Git files')
-- カラースキーム選択 (Leader + fc)
map('n', '<leader>fc', function() Snacks.picker.colorschemes() end, 'Colorschemes')
-- コマンド履歴 (Leader + fch)
map('n', '<leader>fch', function() Snacks.picker.command_history() end, 'Command history')
-- キーマップ検索 (Leader + fk)
map('n', '<leader>fk', function() Snacks.picker.keymaps() end, 'Keymaps')
-- 診断検索 (Leader + sd)
map('n', '<leader>sd', function() Snacks.picker.diagnostics() end, 'Diagnostics')
-- バッファ診断検索 (Leader + sD)
map('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, 'Buffer Diagnostics')
-- LSP シンボル検索 (Leader + ss)
map('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end, 'LSP Symbols')
-- LSP ワークスペースシンボル検索 (Leader + sS)
map('n', '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, 'LSP Workspace Symbols')
-- カーソル下の単語をgrep (Leader + sw)
map({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end, 'Grep Word')
-- Undo 履歴 (Leader + su)
map('n', '<leader>su', function() Snacks.picker.undo() end, 'Undo History')
-- Quickfix リスト (Leader + sq)
map('n', '<leader>sq', function() Snacks.picker.qflist() end, 'Quickfix List')
-- マーク検索 (Leader + sm)
map('n', '<leader>sm', function() Snacks.picker.marks() end, 'Marks')
-- ジャンプリスト (Leader + sj)
map('n', '<leader>sj', function() Snacks.picker.jumps() end, 'Jumps')
-- 検索再開 (Leader + sR)
map('n', '<leader>sR', function() Snacks.picker.resume() end, 'Resume')
-- Git ステータス (Leader + gs)
map('n', '<leader>gs', function() Snacks.picker.git_status() end, 'Git Status')

-- Oil
-- 親ディレクトリを開く (-)
map('n', '<leader>e', '<CMD>Oil<CR>', 'Open file explorer')

-- Oil バッファ内でのキーマップ
vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function()
        local actions = require("oil.actions")
        local function buf_map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = true, silent = true, desc = desc })
        end

        buf_map("n", "g?", actions.show_help.callback, "Show help")
        buf_map("n", "<CR>", actions.select.callback, "Select")
        buf_map("n", "<C-v>", actions.select_vsplit.callback, "Select vsplit")
        buf_map("n", "<C-x>", actions.select_split.callback, "Select split")
        buf_map("n", "<C-t>", actions.select_tab.callback, "Select tab")
        buf_map("n", "<C-p>", actions.preview.callback, "Preview")
        buf_map("n", "<C-c>", actions.close.callback, "Close")
        buf_map("n", "R", actions.refresh.callback, "Refresh")
        buf_map("n", "-", actions.parent.callback, "Parent directory")
        buf_map("n", "_", actions.open_cwd.callback, "Open CWD")
        buf_map("n", "`", actions.cd.callback, "CD")
        buf_map("n", "~", actions.tcd.callback, "TCD")
        buf_map("n", "gs", actions.change_sort.callback, "Change sort")
        buf_map("n", "gx", actions.open_external.callback, "Open external")
        buf_map("n", "g.", actions.toggle_hidden.callback, "Toggle hidden")
        buf_map("n", "g\\", actions.toggle_trash.callback, "Toggle trash")
    end,
})

-- vim-sandwich
map('n', 'sa', '<Plug>(operator-sandwich-add)', 'Add surrounding')
map('n', 'sd', '<Plug>(operator-sandwich-delete)', 'Delete surrounding')
map('n', 'sc', '<Plug>(operator-sandwich-replace)', 'Change surrounding')
map('v', 'S', '<Plug>(operator-sandwich-add)', 'Add surrounding in visual mode')

-- Copilot Chat
-- モデル選択 (Leader + cm)
map('n', '<leader>cm', ':CopilotChatModels<CR>', 'Copilot Chat Models')
map('v', '<leader>cm', ':CopilotChatModels<CR>', 'Copilot Chat Models')

-- Comment.nvim
-- 行コメントのトグル (gcc / ノーマル, gc / ビジュアル)
map('n', 'gcc', function() require('Comment.api').toggle.linewise.current() end, 'Toggle line comment')
-- ブロックコメントのトグル (gbc / ノーマル, gb / ビジュアル)
map('n', 'gbc', function() require('Comment.api').toggle.blockwise.current() end, 'Toggle block comment')
-- ビジュアルモードでの行コメントトグル
map('x', 'gc', function()
  local vmode = vim.fn.visualmode()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'nx', false)
  require('Comment.api').toggle.linewise(vmode)
end, 'Toggle line comment (visual)')
-- ビジュアルモードでのブロックコメントトグル
map('x', 'gb', function()
  local vmode = vim.fn.visualmode()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'nx', false)
  require('Comment.api').toggle.blockwise(vmode)
end, 'Toggle block comment (visual)')
