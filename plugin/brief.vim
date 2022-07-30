if exists("g:loaded_brief")
    finish
endif
let g:loaded_brief = 1

command! -nargs=0 Pcurl lua require("pcurl").main()
autocmd FileType pcurl setlocal commentstring=#\ %s

