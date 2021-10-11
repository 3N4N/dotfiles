local M = {}

local get_selection = function()
  -- does not handle rectangular selection
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return lines
end

local get_first_terminal = function()
    terminal_chans = {}

    for _, chan in pairs(vim.api.nvim_list_chans()) do
        if chan["mode"] == "terminal" and chan["pty"] ~= "" then
            table.insert(terminal_chans, chan)
        end
    end

    table.sort(terminal_chans, function(left, right)
        return left["buffer"] < right["buffer"]
    end)

    return terminal_chans[1]["id"]
end

M.sendToTerm = function(visual)
    local first_terminal_chan = get_first_terminal()
    if visual == 0 then
        local line = vim.api.nvim_get_current_line()
        vim.api.nvim_chan_send(first_terminal_chan, line..'\r')
        -- vim.api.nvim_chan_send(first_terminal_chan, "pwd\r")
    else
        local lines = get_selection()
        for _, line in pairs(lines) do
            vim.api.nvim_chan_send(first_terminal_chan, line..'\r')
        end
    end
end

return M
