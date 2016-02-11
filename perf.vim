
source parinfer.vim

" Open our input file and copy it to register 'a'
e tests/really_long_file
normal ggVG"ay
let s:text = @a

" Time Indent Mode
let s:start = reltime()
let s:result = g:ParinferLib.IndentMode(s:text, {})
let s:time = reltime(s:start)
execute 'silent !echo Indent Mode:' reltimestr(s:time)

" Time Paren Mode
let s:start = reltime()
let s:result = g:ParinferLib.ParenMode(s:text, {})
let s:time = reltime(s:start)
execute 'silent !echo Paren Mode:' reltimestr(s:time)

quit
