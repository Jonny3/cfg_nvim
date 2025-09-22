-- vim-global
vim.g.have_nerd_font = true -- Set to true if you have a Nerd Font installed and selected in the terminal

-- vim-optimize
vim.opt.termguicolors = true -- set termguicolors to enable highlight groups

-- vim-options (vim.o)
vim.o.timeoutlen = 400                 -- time to wait for mapped sequence to complete (miliseconds)
vim.o.updatetime = 250                 -- decrease update time
vim.o.relativenumber = true            -- set relative numbered lines
vim.o.numberwidth = 2                  -- set number column width {default = 4}
vim.o.wrap = false                     -- display lines as one long line
vim.o.whichwrap = 'bs<>[]hl'           -- which "horizontal" keys are allowed to travel to prev/next line
vim.o.hlsearch = true                  -- set highlight on search
vim.o.ignorecase = true                -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true                 -- smart case
vim.o.breakindent = true               -- Enable break indent
vim.o.smartindent = true               -- make indenting smarter again
vim.o.autoindent = true                -- copy indent from current line when starting new one
vim.o.scrolloff = 4                    -- minimal number of screen lines to keep above and below cursor
vim.o.sidescrolloff = 8                -- minimal number of screen columns either side of cursor if wrap is false
vim.o.numberwidth = 2                  -- set number column width {default 4}
vim.o.shiftwidth = 4                   -- the number of spaces inserted for each indentation
vim.o.tabstop = 4                      -- insert n spaces for a tab
vim.o.softtabstop = 4                  -- number of spaces that a tab counts for while performing editing opterations
vim.o.expandtab = true                 -- convert tabs to spaces
vim.o.mouse = 'a'                      -- enable mouse mode
vim.o.clipboard = 'unnamedplus'        -- sync clipboard betweend OS and neovim
vim.undofile = true                    -- save undo history
vim.o.backup = false                   -- creates backup file
vim.o.writebackup = false              -- if file is being edited by another program, it is not allowed to be edited
vim.o.fileencoding = 'utf-8'           -- the encoding written to a file
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.o.swapfile = false                 -- creates a swapfile
vim.o.showmode = false                 -- we don't need to see things like -- INSERT -- anymore
vim.o.showtabline = 0                  -- always show tabs
vim.o.backspace = 'indent,eol,start'   -- allow backspace on
vim.o.cmdheight = 1                    -- more space in the neovim command line for displaying messages
vim.o.cursorline = true                -- highlight the current line
vim.o.splitbelow = true                -- force all horizontal splits to go below current window
vim.o.splitright = true                -- force all vertical splits to go to the right of current window

-- vim-windows options (vim.wo)
vim.wo.number = true      -- make line numbers default
vim.wo.signcolumn = 'yes' -- Keep signcolumn on by default
