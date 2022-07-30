if exists("b:current_syntax")
  finish
endif

syntax keyword pcurlKeywords    curl
syntax match   pcurlOption      /--\w*/
syntax region  pcurlComment     start="#" end="$"
syntax region  pcurlString      start=/'/ end=/'/

syntax match   pcurlRequest     /--request.*$/ contains=pcurlVerbs
syntax region  pcurlVerbs       start=/\s/ end=/$/ contained

" syntax include @INCJSON         <sfile>:p:h/customJson.vim
syntax include @INCJSON         syntax/json.vim
syntax region  pcurlJson        start=/--json\s*'/ end=/'/ contains=pcurlJsonString
syntax region  pcurlJsonString  start=/'{/ end=/}'/ contains=@INCJSON

highlight default link pcurlKeywords    Function
highlight default link pcurlVerbs       PreProc
highlight default link basmRegisters    Special
highlight default link pcurlComment     Comment
highlight default link pcurlString      String
highlight default link pcurlOption      Type
highlight default link pcurlRequest     Type
highlight default link pcurlJson        Type

" change to 'syntax/json.vim' to also highlight double quotes
syntax region jsonKeyword start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ concealends contained
syntax region jsonString oneline start=/"/  skip=/\\\\\|\\"/  end=/"/ concealends contains=jsonEscape contained

let b:current_syntax = "pcurl"

