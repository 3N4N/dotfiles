local M = {}

M.docformat_text = function()
    local cmntstr = vim.api.nvim_buf_get_option(0, "cms")
    local beauty = string.gsub(cmntstr, "%%s", " "..string.rep("-",70))

    vim.cmd('center')
    local curline = vim.api.nvim_get_current_line()
    local newline = string.gsub(cmntstr, "%%s", curline)
    vim.api.nvim_set_current_line(newline)

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.fn.append(pos[1]-1, beauty)
    vim.fn.append(pos[1]+1, beauty)
end

M.docinfo = function()
    local cmntstr = vim.api.nvim_buf_get_option(0, "cms")
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.fn.append(pos[1]-1, (string.gsub(cmntstr, "%%s", "Name:\t\tEnan Ajmain")))
    vim.fn.append(pos[1]+0, (string.gsub(cmntstr, "%%s", "Email:\t\t3nan.ajmain@gmail.com")))
    vim.fn.append(pos[1]+1, (string.gsub(cmntstr, "%%s", "Github:\t\t3N4N")))
end

return M
