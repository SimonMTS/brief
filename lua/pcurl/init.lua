local function create_win()
    start_win = vim.api.nvim_get_current_win()

    vim.api.nvim_command('botright vnew')
    win = vim.api.nvim_get_current_win()
    buf = vim.api.nvim_get_current_buf()

    vim.api.nvim_buf_set_name(buf, 'pcurl-win #' .. buf)

    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(buf, 'swapfile', false)
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(buf, 'filetype', 'pcurl-win')

    vim.api.nvim_set_current_win(start_win)

    -- mappings
    vim.api.nvim_buf_set_keymap(buf, 'n', 'r', ':Pcurl<cr>', {
        nowait = true,
        noremap = true,
        silent = true
    })
end

local function redraw()
    local output = vim.split(vim.api.nvim_exec("!pcurl %", true):gsub("\r", ""), '\n')
    table.remove(output, 1)
    table.remove(output, 1)
    table.remove(output)

    vim.api.nvim_buf_set_option(buf, 'modifiable', true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
end

-- https://www.2n.pl/blog/how-to-make-ui-for-neovim-plugins-in-lua
local function main()
    if win and vim.api.nvim_win_is_valid(win) then
        -- vim.api.nvim_set_current_win(win)
    else
        create_win()
    end

    redraw()
end

return {
    main = main
}

