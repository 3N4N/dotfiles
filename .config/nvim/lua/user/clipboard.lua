require('osc52').setup {
  max_length = 0,      -- Maximum length of selection (0 for no limit)
  silent     = true,   -- Disable message on successful copy
  trim       = false,  -- Trim surrounding whitespaces before copy
}

local function copy(lines, _)
  require('osc52').copy(table.concat(lines, '\n'))
end

-- paste doesn't really work
-- copying from outside nvim doesnt update nvim register
-- must make do with ctrl+shift+v for now
local function paste()
  return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end

-- if vim.g.env == 'UNIX' then
--   vim.g.clipboard = {
--     name = 'xclip',
--     copy = {
--       ['+'] = 'xclip -selection clipboard',
--       ['*'] = 'xclip -selection clipboard',
--     },
--     paste = {
--       ['+'] = 'xclip -selection clipboard -o',
--       ['*'] = 'xclip -selection clipboard -o',
--     },
--   }
-- elseif vim.g.env == 'WSL' then
--   vim.g.clipboard = {
--     name = 'wslyank',
--     copy = {
--       ['+'] = 'wslyank -i',
--       ['*'] = 'wslyank -i',
--     },
--     paste = {
--       ['+'] = 'wslyank -o',
--       ['*'] = 'wslyank -o',
--     },
--   }
-- end

vim.g.clipboard = {
  name = 'osc52',
  copy = {['+'] = copy, ['*'] = copy},
  paste = {['+'] = paste, ['*'] = paste},
}

-- vim.o.clipboard = 'unnamed'
