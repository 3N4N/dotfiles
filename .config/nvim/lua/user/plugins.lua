-- Netrw ---------------------------------------------------------------------

vim.g.netrw_altv = 1
vim.g.netrw_banner = 1
vim.g.netrw_browse_split = 0
vim.g.netrw_cursor = 0
vim.g.netrw_hide = 1
-- vim.g.netrw_list_hide = "^\./$,^\../$,^\.git/$"
vim.g.netrw_list_hide = "^.git$"
vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "name"
vim.g.netrw_sort_direction = "normal"
vim.g.netrw_winsize = 25


-- Closetag ------------------------------------------------------------------

vim.g.closetag_filetypes = "html,xhtml,phtml,javascript"
vim.g.closetag_xhtml_filetypes = "xhtml,jsx,javascript"
vim.g.closetag_emptyTags_caseSensitive = 1
vim.g.closetag_shortcut = ">"
vim.g.closetag_close_shortcut = ""


-- Prettier ------------------------------------------------------------------

vim.g['prettier#autoformat_config_present'] = 1
-- vim.g['prettier#autoformat_require_pragma'] = 0
-- vim.g['prettier#autoformat'] = 0


-- Editor Config -------------------------------------------------------------

vim.g.EditorConfig_disable_rules = {'end_of_line'}


-- Rainbow Parentheses -------------------------------------------------------

vim.g.lisp_rainbow = 0
vim.g.rainbow_active = 1
