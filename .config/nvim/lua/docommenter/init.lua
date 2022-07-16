-- TODO:
-- use nvim api instead of vim.fn.append


local M = {}

M.docformat_text = function()
  local cmntstr = vim.api.nvim_buf_get_option(0, "cms")
  local cmntlen = vim.o.textwidth ~= 0 and vim.o.textwidth or 80
  cmntlen = cmntlen - string.len(cmntstr)

  local beauty = string.gsub(cmntstr, "%%s", " "..string.rep("-",cmntlen))

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
  vim.fn.append(pos[1]-1, (string.gsub(cmntstr, "%%s", "Author: Enan Ajmain")))
  vim.fn.append(pos[1]+0, (string.gsub(cmntstr, "%%s", "Email : 3nan.ajmain@gmail.com")))
  vim.fn.append(pos[1]+1, (string.gsub(cmntstr, "%%s", "Github: 3N4N")))
end

return M
