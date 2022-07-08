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
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
            ["+"] = "win32yank.exe -o --lf",
            ["*"] = "win32yank.exe -o --lf",
        },
        cache_enabled = 1,
    }
end

vim.opt.clipboard:append("unnamed")
