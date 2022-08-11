-- Statusline ----------------------------------------------------------------

vim.opt.laststatus = 2

PathShortenIfLong = function(path)
  if string.len(path) > vim.fn.winwidth(0) - 10 then
    return vim.fn.pathshorten(path)
  end
  return path
end

vim.opt.statusline = " %{&modified?'Δ':&readonly||!&modifiable?'ø':'✓'}"
vim.opt.statusline:append(" %<%{expand('%:~:.')!=#''?v:lua.PathShortenIfLong(expand('%:~:.')):'[No Name]'}")
vim.opt.statusline:append("%=")
vim.opt.statusline:append(" %l: %v ")


-- Tabline -------------------------------------------------------------------

MyTabLine = function()
  local s = ""
  for i = 1, vim.fn.tabpagenr('$') do
    local tabnr = i
    local winnr = vim.fn.tabpagewinnr(tabnr)
    local buflist = vim.fn.tabpagebuflist(tabnr)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t')
    s = s .. "%" .. tabnr .. "T"
    if tabnr == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end
    s = s .. " " .. tabnr
    if bufname == "" then
      s = s .. " [No Name] "
    else
      s = s .. " " .. bufname .. " "
    end
  end
  s = s .. "%#TabLineFill#"
  return s
end

vim.opt.showtabline = 1
vim.opt.tabline = '%!v:lua.MyTabLine()'

