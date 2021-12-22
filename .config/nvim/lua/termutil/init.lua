local M = {}


M.sendToTerm = function(visual)
    assert(vim.g.termutilchan, "g:termutilchan not set")

    local termutilchan = vim.g.termutilchan

    if visual == 0 then
        local line = vim.api.nvim_get_current_line()
        vim.api.nvim_chan_send(termutilchan, line..'\r')
    else
        local lines = require("luautil.selection").get_selection()
        for _, line in pairs(lines) do
            vim.api.nvim_chan_send(termutilchan, line..'\r')
        end
        if vim.bo.filetype == "python" then
            vim.api.nvim_chan_send(termutilchan, '\r')
        end
    end
end

return M
