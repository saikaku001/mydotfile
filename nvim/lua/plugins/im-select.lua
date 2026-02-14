if vim.fn.has("macunix") ~= 1 then
    return {}
end
return {
    "keaising/im-select.nvim",
    config = function()
        require("im_select").setup({
            default_im_select = "com.apple.keylayout.ABC",
            set_im_cmd = function(im_key)
                return { "macism", im_key }
            end,
            get_im_cmd = "macism",
        })
    end,
}
