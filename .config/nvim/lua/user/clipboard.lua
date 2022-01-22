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
elseif vim.g.env == "WSL" then
    vim.g.clipboard = {
        name = "win32yank_nvim",
        copy = {
            ["+"] = "win32yank.exe -i",
            ["*"] = "win32yank.exe -i",
        },
        paste = {
            ["+"] = "win32yank.exe -o",
            ["*"] = "win32yank.exe -o",
        },
        cache_enabled = 1,
    }
end

vim.opt.clipboard:append("unnamed")
