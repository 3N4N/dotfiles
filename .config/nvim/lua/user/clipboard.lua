if vim.g.env == "UNIX" then
    vim.g.clipboard = {
        name = "xclip_nvim",
        copy = {
            ["+"] = "xclip -selection clipboard",
            ["*"] = "xclip -selection clipboard",
        },
        paste = {
            ["+"] = "xclip -selection clipboard -o",
            ["*"] = "xclip -selection clipboard -o",
        },
        cache_enabled = 1,
    }
end

vim.opt.clipboard:append("unnamed")
