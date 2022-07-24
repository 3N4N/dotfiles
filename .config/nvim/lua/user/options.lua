-- Colorscheme
vim.cmd([[ syntax on ]])
vim.opt.termguicolors = true
vim.opt.background = "light"
vim.cmd([[ colo violet ]])
-- vim.g.colors_name = "violet"


-- Visual perks
vim.opt.conceallevel = 0
vim.opt.cursorcolumn = false
vim.opt.cursorline = false
vim.opt.lazyredraw = false
vim.opt.modeline = false
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.ruler = false
vim.opt.showmode = true
vim.opt.signcolumn = "no"
vim.opt.colorcolumn = {0}
vim.opt.fillchars = "vert:│"
vim.opt.guicursor = ""
vim.o.mouse = ""


-- New split position
vim.opt.splitbelow = false
vim.opt.splitright = false

-- Dictionary and spelling
vim.opt.dictionary = "/usr/share/dict/words,~/AppData/Local/nvim/spell/american-english"
vim.opt.spelllang= "en_us"

-- Set default shell in windows
if vim.g.env == "WIN" then
    vim.opt.shell = "C:\\\\Windows\\\\System32\\\\cmd.exe"
    vim.opt.shellredir = ">%s 2>&1"
    vim.opt.shellpipe = ">%s 2>&1"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = "\""
    vim.opt.ssl = false
    vim.opt.csl = "slash"
end

-- vim.opt.shell = 'pwsh -nop'
-- vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
-- vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
-- vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
-- vim.opt.shellquote = ""
-- vim.opt.shellxquote = ""
-- -- vim.opt.ssl = false


-- Searching
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.cmd [[noh]]


if vim.g.env == "WIN" then
    vim.opt.grepprg = "grep -IHnri --exclude-dir=.git --exclude-dir=node_modules --exclude=\"tags\""
else
    vim.opt.grepprg = "grep -IHnri --exclude-dir={.git,node_modules} --exclude=\"tags\""
end

-- Wildmenu settings
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildmode = "full"
vim.opt.wildoptions = "pum"
vim.opt.pumblend=0
vim.opt.complete:remove("t")
vim.opt.wildignore = {}
vim.opt.wildignore:append("*.o,*.obj,*~,*.class")
vim.opt.wildignore:append("*/.git")
vim.opt.wildignore:append("*.swp,*.tmp")
vim.opt.wildignore:append("*.mp3,*.mp4,*mkv")
vim.opt.wildignore:append("*.bmp,*.gif,*ico,*.jpg,*.png")
vim.opt.wildignore:append("*.pdf,*.doc,*.docx,*.ppt,*.pptx")
vim.opt.wildignore:append("*.rar,*.zip,*.tar,*.tar.gz,*.tar.xz")

-- Show useful visual icons
vim.opt.list = true
vim.opt.listchars:append({ tab = "┆ " })
vim.opt.listchars:append({ trail = "▫" })
vim.opt.listchars:append({ nbsp = "_" })
vim.opt.listchars:append({ extends = "»" })
vim.opt.listchars:append({ precedes = "«" })

-- Wrap lines visually
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "

-- Folding
vim.opt.foldcolumn = "0"
vim.opt.foldmethod = "manual"

-- Keymap timeout settings
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 10

-- Miscellaneous settings
vim.opt.cpoptions:remove("aA")
vim.opt.joinspaces = false
vim.opt.inccommand = "nosplit"
vim.opt.backspace = "indent,eol,start"
vim.opt.cinoptions = "g0,l1,i0,t0,(4,N-s"
vim.opt.shortmess = "filmnxrtToO"
vim.opt.synmaxcol = 200
vim.opt.updatetime = 250
vim.opt.virtualedit = "block"
vim.opt.viewoptions = "folds,cursor"
vim.opt.formatoptions = "tcqjro"
vim.opt.diffopt = "internal,filler,closeoff,iwhiteall,algorithm:patience,indent-heuristic"

vim.g.R_assign = 2
vim.g.tex_flavor = "latex"

-- Backup and swap

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

if vim.g.env == "WIN" then
    vim.opt.backupdir = vim.fn.expand("~/AppData/Local/nvim-data/backup/")
    vim.opt.directory = vim.fn.expand("~/AppData/Local/nvim-data/swap/")
    vim.opt.undodir = vim.fn.expand("~/AppData/Local/nvim-data/undo/")
else
    vim.opt.backupdir = vim.fn.expand("~/.local/share/nvim/backup//")
    vim.opt.directory = vim.fn.expand("~/.local/share/nvim/swap//")
    vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/undo//")
end

-- Tab settings --------------------------------------------------------------

vim.opt.smarttab = true
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Make ----------------------------------------------------------------------

if vim.fn.isdirectory("build") == 1 then
    -- vim.opt.makeprg = "make -C build"
    vim.opt.makeprg = "ninja -C build"
else
    vim.opt.makeprg = "make"
end
