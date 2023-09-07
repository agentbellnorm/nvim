local M = {}
local buffer_list = {}

local function map(tbl, func)
    local newTbl = {}
    for i, v in ipairs(tbl) do
        newTbl[i] = func(v, i)
    end
    return newTbl
end

vim.api.nvim_exec([[
    augroup Stacked
        autocmd!
        autocmd BufEnter * lua require'stacked'.track_buffer()
    augroup END

]], false)

M.track_buffer = function()
    local cur_buf = vim.api.nvim_get_current_buf()

    local buftype = vim.api.nvim_buf_get_option(cur_buf, 'buftype')

    if buftype ~= "" then
        -- print("has a buftype so skipping", buftype)
        return
    end

    -- print("no buftype, add to list", buftype)


    for i, buf in ipairs(buffer_list) do
        if buf == cur_buf then
            table.remove(buffer_list, i)
            break
        end
    end

    table.insert(buffer_list, 1, cur_buf)
end

M.close_popup = function()
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_close(win, true)
end

M.select_buffer = function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local buf_id = buffer_list[line]
    M.close_popup()
    vim.api.nvim_set_current_buf(buf_id)
end

M.switch_buffer = function()
    local buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_lines(buf, 0, -1, false,
        map(buffer_list, function(buffer)
            return vim.api.nvim_buf_get_name(buffer)
        end)
    )

    local width = 80 -- todo length of longest path, or window width
    local height = #buffer_list
    local win_opts = {
        relative = "editor",
        width = width,
        height = height,
        col = (vim.o.columns - width) / 2,
        row = (vim.o.lines - height) / 2,
        style = "minimal",
        border = "rounded"
    }

    local win = vim.api.nvim_open_win(buf, true, win_opts)
    if #buffer_list > 1 then
        vim.api.nvim_win_set_cursor(win, {2, 0})
    end

    vim.api.nvim_buf_set_keymap(buf, 'n', '<Enter>',
        ':lua require"stacked".select_buffer()<CR>',
        { noremap = true, silent = true })

    vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>',
        ':lua require"stacked".close_popup()<CR>',
        { noremap = true, silent = true })
    

    vim.api.nvim_buf_set_keymap(buf, 'n', '<TAB>', 'j', { noremap = true, silent = true })
end

return M
