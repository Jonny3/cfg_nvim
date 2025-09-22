-- Set lualine as statusline
return {
    "nvim-lualine/lualine.nvim",
    config = function()
        -- Adapted from: https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/themes/onedark.lua
        local colors = {
            blue = "#61afef",
            green = "#98c379",
            purple = "#c678dd",
            cyan = "#56b6c2",
            red1 = "#e06c75",
            red2 = "#be5046",
            yellow = "#e5c07b",
            fg = "#abb2bf",
            bg = "#282c34",
            gray1 = "#828997",
            gray2 = "#2c323c",
            gray3 = "#3e4452",
        }

        local lualine_theme = {
            normal = {
                a = { fg = colors.bg, bg = colors.green, gui = "bold" },
                b = { fg = colors.fg, bg = colors.gray3 },
                c = { fg = colors.fg, bg = colors.gray2 },
                -- x = { fg = colors.bg, bg = colors.green, gui = "bold" },
                -- y = { fg = colors.bg, bg = colors.green, gui = "bold" },
                z = { fg = colors.bg, bg = colors.green, gui = "bold" },
            },
            command = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
            insert = { a = { fg = colors.bg, bg = colors.blue, gui = "bold" } },
            visual = { a = { fg = colors.bg, bg = colors.purple, gui = "bold" } },
            terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = "bold" } },
            replace = { a = { fg = colors.bg, bg = colors.red1, gui = "bold" } },
            inactive = {
                a = { fg = colors.gray1, bg = colors.bg, gui = "bold" },
                b = { fg = colors.gray1, bg = colors.bg },
                c = { fg = colors.gray1, bg = colors.gray2 },
            },
        }

        -- Define a table of themes
        local themes = {
            lualine_theme = lualine_theme,
        }

        local mode = {
            "mode",
            fmt = function(str)
                -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
                return " " .. str
            end,
        }

        local filename_deac = {
            "filename",
            file_status = false, -- displays file status (readonly status, modified status)
            path = 1,            -- 0 = just filename, 1 = relative path, 2 = absolute path
        }

        local filename_acv = {
            "filename",
            path = 1,
            symbols = {
                modified = '', -- Text to show when the file is modified.
                readonly = '', -- Text to show when the file is non-modifiable or readonly.
                unnamed = '', -- Text to show for unnamed buffers.
                newfile = '', -- Text to show for newly created file before first write
            }
        }
        local hide_in_width = function()
            return vim.fn.winwidth(0) > 100
        end

        local buff_acv = function()
            return #vim.api.nvim_list_bufs() > 0
        end

        local diagnostics = {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            colored = false,
            update_in_insert = false,
            always_visible = false,
            cond = hide_in_width,
        }

        local diff = {
            "diff",
            colored = false,
            symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
            cond = hide_in_width,
        }

        local lsp = {
            "lsp_status",
            cond = buff_acv,
        }

        local tabs = {
            "tabs",
            show_modified_status = false, -- Shows a symbol next to the tab name if the file has been modified.
        }

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = themes.lualine_theme, -- Set theme based on environment variable
                -- Some useful glyphs:
                -- https://www.nerdfonts.com/cheat-sheet
                --        
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                disabled_filetypes = { "alpha", "neo-tree", "Avante" },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { mode, "branch" },
                lualine_b = { tabs },
                lualine_c = { filename_acv, lsp },
                lualine_x = {
                    diagnostics,
                    diff,
                    { "encoding", cond = hide_in_width },
                    { "filetype", cond = hide_in_width },
                },
                lualine_y = { "location" },
                lualine_z = { "progress" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { filename_deac },
                lualine_x = { { "location", padding = 0 } },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {
                -- lualine_a = { { "filename" } },
                -- lualine_z = { tabs },
            },
            extensions = { "fugitive", "nvim-tree" },
        })
    end,
}
