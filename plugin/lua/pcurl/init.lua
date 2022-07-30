local function pcurl_vsplit()
    local file = vim.fn.expand("%:p")
    vim.cmd("vsplit | terminal")
    local command = ':call jobsend(b:terminal_job_id, "clear && go run .. ' .. file .. '\\n")'
    vim.cmd(command)
end

local function set_mappings()
    -- vim.api.nvim_buf_set_keymap(buf, 'n', k, ':lua require"nvim-oldfile".'..v..'<cr>', {
    --     nowait = true, noremap = true, silent = true
    --   })
end


local function create_win()
    -- We save handle to window from which we open the navigation
    start_win = vim.api.nvim_get_current_win()

    vim.api.nvim_command('botright vnew') -- We open a new vertical window at the far right
    win = vim.api.nvim_get_current_win() -- We save our navigation window handle...
    buf = vim.api.nvim_get_current_buf() -- ...and it's buffer handle.

    -- We should name our buffer. All buffers in vim must have unique names.
    -- The easiest solution will be adding buffer handle to it
    -- because it is already unique and it's just a number.
    vim.api.nvim_buf_set_name(buf, 'pcurl-win #' .. buf)

    -- Now we set some options for our buffer.
    -- nofile prevent mark buffer as modified so we never get warnings about not saved changes.
    -- Also some plugins treat nofile buffers different.
    -- For example coc.nvim don't triggers aoutcompletation for these.
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    -- We do not need swapfile for this buffer.
    vim.api.nvim_buf_set_option(buf, 'swapfile', false)
    -- And we would rather prefer that this buffer will be destroyed when hide.
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    -- It's not necessary but it is good practice to set custom filetype.
    -- This allows users to create their own autocommand or colorschemes on filetype.
    -- and prevent collisions with other plugins.
    vim.api.nvim_buf_set_option(buf, 'filetype', 'pcurl-win')

    -- For better UX we will turn off line wrap and turn on current line highlight.
    -- vim.api.nvim_win_set_option(win, 'wrap', false)
    -- vim.api.nvim_win_set_option(win, 'cursorline', true)

    -- autocmd FileType pcurl setlocal commentstring=#\ %s


    vim.api.nvim_set_current_win(start_win)

    -- set_mappings() -- At end we will set mappings for our navigation.
end

local function redraw()
    -- First we allow introduce new changes to buffer. We will block that at end.
    vim.api.nvim_buf_set_option(buf, 'modifiable', true)

    local list = {}
    table.insert(list, #list + 1, "testing")
    table.insert(list, #list + 1, "line2")

    local output = vim.split(vim.api.nvim_exec("! /home/simon/docs/git/pcurl/dist/pcurl %", true):gsub("\r", ""), '\n')
    table.remove(output, 1)
    table.remove(output, 1)
    table.remove(output)

    -- We apply results to buffer
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
    -- vim.api.nvim_exec("%s/\r//g", true)
    -- And turn off editing
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
    pcurl_vsplit = pcurl_vsplit,
    main = main
}

