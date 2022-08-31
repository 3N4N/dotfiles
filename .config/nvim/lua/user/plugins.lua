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


-- treesitter ----------------------------------------------------------------

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "python", "markdown", "comment" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "vim", "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
