if exists("g:loaded_brief")
    finish
endif
let g:loaded_brief = 1

command! -nargs=0 Brief lua require("brief").main()
autocmd FileType brief setlocal commentstring=#\ %s

