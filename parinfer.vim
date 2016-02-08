"" parinfer.vim - a Parinfer implementation in Vimscript
"" v0.1.0+dev
"" https://github.com/oakmac/parinfer-viml
""
"" More information about Parinfer can be found here:
"" http://shaunlebron.github.io/parinfer/
""
"" Copyright (c) 2015, Chris Oakman and other contributors
"" Released under the ISC license
"" https://github.com/oakmac/parinfer-viml/blob/master/LICENSE.md

""------------------------------------------------------------------------------
"" Constants / Predicates
""------------------------------------------------------------------------------

let s:SENTINEL_NULL = -999

let s:INDENT_MODE = 'INDENT_MODE'
let s:PAREN_MODE = 'PAREN_MODE'

let s:BACKSLASH = '\'
let s:BLANK_SPACE = ' '
let s:DOUBLE_SPACE = '  '
let s:DOUBLE_QUOTE = '"'
let s:NEWLINE = "\n"
let s:SEMICOLON = ';'
let s:TAB = "\t"

let s:PARENS = {
  \ '(': ')',
  \ '{': '}',
  \ '[': ']',
  \ ')': '(',
  \ '}': '{',
  \ ']': '[',
  \ }


function! s:IsOpenParen(ch)
    return a:ch ==# '(' || a:ch ==# '{' || a:ch ==# '['
endfunction


function! s:IsCloseParen(ch)
    return a:ch ==# ')' || a:ch ==# '}' || a:ch ==# ']'
endfunction

""------------------------------------------------------------------------------
"" Result Structure
""------------------------------------------------------------------------------

function! s:CreateInitialResult(text, mode, options)
    return {
      \ 'mode': a:mode,

      \ 'origText': a:text,
      \ 'origLines': split(a:text, s:NEWLINE),

      \ 'lines': [],
      \ 'lineNo': -1,
      \ 'ch': '',
      \ 'x': 0,

      \ 'parenStack': [],

      \ 'parenTrailLineNo': s:SENTINEL_NULL,
      \ 'parenTrailStartX': s:SENTINEL_NULL,
      \ 'parenTrailEndX': s:SENTINEL_NULL,
      \ 'parenTrailOpeners': [],

      \ 'cursorX': s:SENTINEL_NULL,
      \ 'cursorLine': s:SENTINEL_NULL,
      \ 'cursorDx': s:SENTINEL_NULL,

      \ 'isInCode': 1,
      \ 'isEscaping': 0,
      \ 'isInStr': 0,
      \ 'isInComment': 0,
      \ 'commentX': s:SENTINEL_NULL,

      \ 'quoteDanger': 0,
      \ 'trackingIndent': 0,
      \ 'skipChar': 0,
      \ 'success': 0,

      \ 'maxIndent': s:SENTINEL_NULL,
      \ 'indentDelta': 0,

      \ 'error': s:SENTINEL_NULL,
      \ 'errorPosCache': {},
      \ }
endfunction

""------------------------------------------------------------------------------
"" Errors
""------------------------------------------------------------------------------

let s:ERROR_QUOTE_DANGER = 'quote-danger'
let s:ERROR_EOL_BACKSLASH = 'eol-backslash'
let s:ERROR_UNCLOSED_QUOTE = 'unclosed-quote'
let s:ERROR_UNCLOSED_PAREN = 'unclosed-paren'

let s:ERROR_MESSAGES = {}
let s:ERROR_MESSAGES[s:ERROR_QUOTE_DANGER] = 'Quotes must balanced inside comment blocks.'
let s:ERROR_MESSAGES[s:ERROR_EOL_BACKSLASH] = 'Line cannot end in a hanging backslash.'
let s:ERROR_MESSAGES[s:ERROR_UNCLOSED_QUOTE] = 'String is missing a closing quote.'
let s:ERROR_MESSAGES[s:ERROR_UNCLOSED_PAREN] = 'Unmatched open-paren.'


function! s:CacheErrorPos(result, errorName, lineNo, x)
    let a:result.errorPosCache[a:errorName] = {'lineNo': a:lineNo, 'x': a:x,}
endfunction


function! s:CreateError(result, errorName, lineNo, x)
    "" TODO: write me
endfunction


""------------------------------------------------------------------------------
"" String Operations
""------------------------------------------------------------------------------


function! s:InsertWithinString(orig, idx, insert)
    return strpart(a:orig, 0, a:idx) . a:insert . strpart(a:orig, a:idx)
endfunction


function! s:ReplaceWithinString(orig, startIdx, endIdx, replace)
    return strpart(a:orig, 0, a:startIdx) . a:replace . strpart(a:orig, a:endIdx)
endfunction


function! s:RemoveWithinString(orig, startIdx, endIdx)
    return strpart(a:orig, 0, a:startIdx) . strpart(a:orig, a:endIdx)
endfunction


function! s:RepeatString(text, n)
    let l:result = ''
    let l:i = 0
    while l:i < a:n
        let l:result = l:result . a:text
        let l:i = (l:i + 1)
    endwhile
    return l:result
endfunction


""------------------------------------------------------------------------------
"" Line operations
""------------------------------------------------------------------------------


function! s:InsertWithinLine(result, lineNo, idx, insert)
    let l:line = a:result.lines[a:lineNo]
    let a:result.lines[a:lineNo] = s:InsertWithinString(l:line, a:idx, a:insert)
endfunction


function! s:ReplaceWithinLine(result, lineNo, startIdx, endIdx, replace)
    let l:line = a:result.lines[a:lineNo]
    let a:result.lines[a:lineNo] = s:ReplaceWithinString(l:line, a:startIdx, a:endIdx, a:replace)
endfunction


function! s:RemoveWithinLine(result, lineNo, startIdx, endIdx)
    let l:line = a:result.lines[a:lineNo]
    let a:result.lines[a:lineNo] = s:RemoveWithinString(l:line, a:startIdx, a:endIdx)
endfunction


function! s:InitLine(result, line)
    let a:result.x = 0
    let a:result.lineNo = a:result.lineNo + 1
    add(a:result.lines, line)

    "" reset line-specific state
    let a:result.commentX = s:SENTINEL_NULL
    let a:result.indentDelta = 0
endfunction


function! s:CommitChar(result, origCh)
    let l:ch = a:result.ch
    if a:origCh !=# l:ch
        s:ReplaceWithinLine(a:result, a:result.lineNo, a:result.x, a:result.x + strlen(a:origCh), l:ch)
    endif
    let a:result.x = a:result.x + strlen(l:ch)
endfunction


""------------------------------------------------------------------------------
"" Misc Util
""------------------------------------------------------------------------------


function! s:Clamp(valN, minN, maxN)
    let l:returnVal = a:valN
    if a:minN != s:SENTINEL_NULL
        if a:minN > l:returnVal
            let l:returnVal = a:minN
        endif
    endif

    if a:maxN != s:SENTINEL_NULL
        if a:maxN < l:returnVal
            let l:returnVal = a:maxN
        endif
    endif

    return l:returnVal
endfunction


function! s:Peek(arr)
    if len(a:arr) == 0
        return s:SENTINEL_NULL
    endif
    return a:arr[-1]
endfunction


"" removes the last item from a list
"" if the list is already empty, does nothing
function! s:Pop(arr)
    if len(a:arr) == 0
        return []
    endif
    return a:arr[0:-2]
endfunction


""------------------------------------------------------------------------------
"" Character functions
""------------------------------------------------------------------------------


function! s:IsValidCloseParen(parenStack, ch)
    if len(a:parenStack) == 0
        return 0
    endif
    return s:Peek(a:parenStack).ch ==# s:PARENS[a:ch]
endfunction


function! s:OnOpenParen(result)
    if a:result.isInCode
        let l:newStackEl = {
          \ 'lineNo': a:result.lineNo,
          \ 'x': a:result.x,
          \ 'ch': a:result.ch,
          \ 'indentDelta': a:result.indentDelta,
          \ }
        add(a:result.parenStack, l:newStackEl)
    endif
endfunction


function! s:OnMatchedCloseParen(result)
    let l:opener s:Peek(a:result.parenStack)
    let a:result.parenTrailEndX = a:result.x + 1
    add(a:result.parenTrailOpeners, l:opener)
    let a:result.maxIndent = l:opener.x
    let a:result.parenStack = s:Pop(a:result.parenStack)
endfunction


function! s:OnUnmatchedCloseParen(result)
    let a:result.ch = ''
endfunction


function! s:OnCloseParen(result)
    if a:result.isInCode
        if s:IsValidCloseParen(a:result.parenStack, a:result.ch)
            s:OnMatchedCloseParen(a:result)
        else
            s:OnUnmatchedCloseParen(a:result)
        endif
    endif
endfunction


function! s:OnTab(result)
    if a:result.isInCode
        let a:result.ch = s:DOUBLE_SPACE
    endif
endfunction


function! s:OnSemicolon(result)
    if a:result.isInCode
        let a:result.isInComment = 1
        let a:result.commentX = a:result.x
    endif
endfunction


function! s:OnNewline(result)
    let a:result.isInComment = 0
    let a:result.ch = ''
endfunction


function! s:OnQuote(result)
    if a:result.isInStr
        let a:result.isInStr = 0
    elseif a:result.isInComment
        let a:result.quoteDanger = ! a:result.quoteDanger
        if a:result.quoteDanger
            s:CacheErrorPos(a:result, s:ERROR_QUOTE_DANGER, a:result.lineNo, a:result.x)
        endif
    else
        let a:result.isInStr = 1
        s:CacheErrorPos(a:result, s:ERROR_UNCLOSED_QUOTE, a:result.lineNo, a:result.x)
    endif
endfunction


function! s:OnBackslash(result)
    let a:result.isEscaping = 1
endfunction


function! s:AfterBackslash(result)
    let a:result:isEscaping = 0

    if a:result.ch ==# s:NEWLINE
        if a:result.isInCode
            "" TODO: figure out throw here
            "" throw error(result, ERROR_EOL_BACKSLASH, result.lineNo, result.x - 1);
        endif
        s:OnNewline(a:result)
    endif
endfunction


function! s:OnChar(result)
    let l:ch = a:result.ch
    if a:result.isEscaping
        s:AfterBackslash(a:result)
    elseif s:IsOpenParen(l:ch)
        s:OnOpenParen(a:result)
    elseif s:IsCloseParen(l:ch)
        s:OnCloseParen(a:result)
    elseif l:ch ==# s:DOUBLE_QUOTE
        s:OnQuote(a:result)
    elseif l:ch ==# s:SEMICOLON
        s:OnSemicolon(a:result)
    elseif l:ch ==# s:BACKSLASH
        s:OnBackslash(a:result)
    elseif l:ch ==# s:TAB
        s:OnTab(a:result)
    elseif l:ch ==# s:NEWLINE
        s:OnNewline(a:result)
    endif

    let a:result.isInCode = (! a:result.isInComment) && (! a:result.isInStr)
endfunction


""------------------------------------------------------------------------------
"" Cursor functions
""------------------------------------------------------------------------------

"" TODO: write this section

""------------------------------------------------------------------------------
"" Paren Trail functions
""------------------------------------------------------------------------------

"" TODO: write this section

""------------------------------------------------------------------------------
"" Indentation functions
""------------------------------------------------------------------------------

"" TODO: write this section

""------------------------------------------------------------------------------
"" High-level processing functions
""------------------------------------------------------------------------------

"" TODO: write this section

""------------------------------------------------------------------------------
"" Public API
""------------------------------------------------------------------------------

"" TODO: write this section
