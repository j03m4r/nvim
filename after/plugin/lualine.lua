-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
    blue   = '#61afef',
    cyan   = '#56b6c2',
    black  = '#16161c',
    white  = '#abb2bf',
    red    = '#ff5189',
    violet = '#16161c',
    grey   = '#16161c',
}

local bubbles_theme = {
    normal = {
        a = { fg = colors.grey, bg = colors.blue },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white },
    },

    insert = { a = { fg = colors.grey, bg = colors.blue } },
    visual = { a = { fg = colors.grey, bg = colors.blue } },
    replace = { a = { fg = colors.grey, bg = colors.blue } },

    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white },
    },
}

require('lualine').setup {
    options = {
        theme = bubbles_theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { { 'mode', right_padding = 0 } },
        lualine_b = { 'filename', 'branch' },
        lualine_c = {
            '%=', --[[ add your center compoentnts here in place of this comment ]]
        },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
            { 'location', left_padding = 0 },
        },
    },
    inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
}
