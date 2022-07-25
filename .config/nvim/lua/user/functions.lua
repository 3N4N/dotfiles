local M = {}

M.betterGX = function()
  if vim.g.env == "WSL" then
    cmd = 'cmd.exe /C start ""'
  elseif vim.g.env == "WIN" then
    cmd = 'cmd.exe /C start ""'   -- start's first arg is title
  elseif vim.fn.executable('xdg-open') then
    cmd = "xdg-open"
  elseif vim.fn.executable('open') then
    cmd = "open"
  else
    vim.api.nvim_echo({{"[BetterGX] Can't find proper opener for an URL!", 'Error'}}, false, {})
    return
  end

  path = vim.fn.expand('<cfile>')
  fullcmd = cmd .. ' ' .. '"' .. path .. '"'
  print(fullcmd)
  vim.fn.jobstart(fullcmd)
end

return M
