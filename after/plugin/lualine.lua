require('lualine').setup({
    options = {
        ignore_focus = {
            'NvimTree',
            'fugitive',
            'fugitiveblame',
            'undotree',
            'TelescopePrompt',
            'DiffviewFiles',
        },
        globalstatus = true,
    },
    sections = {
        lualine_c = {
            {
                'filename',
                path = 1,
            }
        },
        lualine_x = { 'filetype' },
    }
})
