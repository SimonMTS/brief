local function create_win()
    EDITOR_WIN = vim.api.nvim_get_current_win()
    EDITOR_BUF = vim.api.nvim_get_current_buf()

    vim.api.nvim_command('botright vnew')
    OUTPUT_WIN = vim.api.nvim_get_current_win()
    OUTPUT_BUF = vim.api.nvim_get_current_buf()

    vim.api.nvim_buf_set_name(OUTPUT_BUF, 'brief-win #' .. OUTPUT_BUF)

    vim.api.nvim_buf_set_option(OUTPUT_BUF, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(OUTPUT_BUF, 'swapfile', false)
    vim.api.nvim_buf_set_option(OUTPUT_BUF, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(OUTPUT_BUF, 'filetype', 'brief-win')

    vim.api.nvim_set_current_win(EDITOR_WIN)

    -- mappings
    vim.api.nvim_buf_set_keymap(OUTPUT_BUF, 'n', 'r', ':Pcurl<cr>', {
        nowait = true,
        noremap = true,
        silent = true
    })
end

local function redraw()
    -- TODO remove comments
    --      insert newline escapes
    -- local output = vim.split(vim.api.nvim_exec("!pcurl %", true):gsub("\r", ""), '\n')
    -- table.remove(output, 1)
    -- table.remove(output, 1)
    -- table.remove(output)
    -- TODO format output

    local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
    -- local output = s:gsub("[ \t]*%-%-[^\n\r]*", "")


    vim.api.nvim_buf_set_option(OUTPUT_BUF, 'modifiable', true)
    vim.api.nvim_buf_set_lines(OUTPUT_BUF, 0, -1, false, content)
    vim.api.nvim_buf_set_option(OUTPUT_BUF, 'modifiable', false)
end

-- https://www.2n.pl/blog/how-to-make-ui-for-neovim-plugins-in-lua
local function main()
    -- TODO maybe model this thing as a FSM

    if OUTPUT_WIN and vim.api.nvim_win_is_valid(OUTPUT_WIN) then
        -- vim.api.nvim_set_current_win(win)
    else
        create_win()
    end

    redraw()
end

return {
    main = main
}

