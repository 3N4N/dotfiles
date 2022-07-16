local M = {}

M.get_selection = function()
  -- does not handle rectangular selection
  local s_start = vim.api.nvim_buf_get_mark(0, "<")
  local s_end = vim.api.nvim_buf_get_mark(0, ">")
  local n_lines = math.abs(s_end[1] - s_start[1]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[1] - 1, s_end[1], false)
  lines[1] = string.sub(lines[1], s_start[2], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[2] - s_start[2] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[2])
  end
  return lines
end

return M
