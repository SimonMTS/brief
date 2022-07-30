if exists("b:current_syntax")
  finish
endif

syntax region  pcurlWinHeaders      start="HTTP" end="\n\n" contains=pcurlWinHead,pcurlWinHeaderVal,pcurlWinHeadOK,pcurlWinHeadBAD,pcurlWinHeadWARN
syntax match   pcurlWinHeadWARN     /HTTP.*$/ contained
syntax match   pcurlWinHeadOK       /HTTP.*2\d\d.*$/ contained
syntax match   pcurlWinHeadBAD      /HTTP.*5\d\d.*$/ contained
syntax match   pcurlWinHeaderVal    /: .*$/hs=s+2 contained
" syntax match   pcurlWinHeaderKey    /^^\{-}:/      contained

highlight default link pcurlWinHeaders      Type
highlight default link pcurlWinHeadWARN     Constant
highlight default link pcurlWinHeadOK       String
highlight default link pcurlWinHeadBAd      Special
highlight default link pcurlWinHeaderVal    PreProc
" highlight default link pcurlWinHeaderKey    Type

let b:current_syntax = "pcurl-win"

