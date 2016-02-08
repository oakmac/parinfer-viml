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

"" NOTE: this should be a variadic function, but for Parinfer's purposes it only
""       needs to be two arity
function! s:Max(x, y)
    if a:y > a:x
        return a:y
    endif
    return a:x
endfunction


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
"" returns the modified (or empty) array
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


function! s:IsCursorOnLeft(result)
    return a:result.lineNo == a:result.cursorLine &&
         \ a:result.cursorX != s:SENTINEL_NULL &&
         \ a:result.cursorX <= a:result.x
endfunction


function! s:IsCursorOnRight(result, x)
    return a:result.lineNo == a:result.cursorLine &&
         \ a:result.cursorX != s:SENTINEL_NULL &&
         \ a:x != s:SENTINEL_NULL &&
         \ a:result.cursorX > a:x
endfunction


function! s:IsCursorInComment(result)
    return s:IsCursorOnRight(a:result, a:result.commentX)
endfunction


function! s:HandleCursorDelta(result)
    let l:hasCursorDelta = a:result.cursorDx != s:SENTINEL_NULL &&
                         \ a:result.cursorLine == a:result.lineNo &&
                         \ a:result.cursorX == a:result.x

    if l:hasCursorDelta
        let a:result.indentDelta = a:result.indentDelta + a:result.cursorDx
    endif
endfunction


""------------------------------------------------------------------------------
"" Paren Trail functions
""------------------------------------------------------------------------------


function! s:UpdateParenTrailBounds(result)
    let l:line = a:result.lines[a:result.lineNo]
    let l:prevCh = s:SENTINEL_NULL
    if a:result.x > 0
        let l:prevCh = l:line[a:result.x - 1]
    endif
    let l:ch = a:result.ch

    let l:shouldReset = a:result.isInCode &&
                      \ ! s:IsCloseParen(l:ch) &&
                      \ l:ch !=# '' &&
                      \ (l:ch !=# s:BLANK_SPACE || l:prevCh ==# s:BACKSLASH) &&
                      \ l:ch !=# s:DOUBLE_SPACE

    if l:shouldReset
        let a:result.parenTrailLineNo = a:result.lineNo
        let a:result.parenTrailStartX = a:result.x + 1
        let a:result.parenTrailEndX = a:result.x + 1
        let a:result.parenTrailOpeners = []
        let a:result.maxIndent = s:SENTINEL_NULL
    endif
endfunction


function! s:ClampParenTrailToCursor(result)
    let l:startX = a:result.parenTrailStartX
    let l:endX = a:result.parenTrailEndX

    let l:isCursorClamping = s:IsCursorOnRight(a:result, l:startX) &&
                           \ ! s:IsCursorInComment(a:result)

    if l:isCursorClamping
        let l:newStartX = s:Max(l:startX, a:result.cursorX)
        let l:newEndX = s:Max(l:endX, a:result.cursorX)

        let l:line = a:result.lines[a:result.lineNo]
        let l:removeCount = 0
        let l:i = l:startX
        while l:i < l:newStartX
            if s:IsCloseParen(l:line[l:i])
                let l:removeCount = l:removeCount + 1
            endif
            let l:i = l:i + 1
        endwhile

        if l:removeCount > 0
            let a:result.parenTrailOpeners = a:result.parenTrailOpeners[l:removeCount : ]
        endif
        let a:result.parenTrailStartX = l:newStartX
        let a:result.parenTrailEndX = l:newEndX
    endif
endfunction


function! s:RemoveParenTrail(result)
    let l:startX = a:result.parenTrailStartX
    let l:endX = a:result.parenTrailEndX

    if l:startX == l:endX
        return
    endif

    let l:openers = a:result.parenTrailOpeners
    let a:result.parenStack = a:result.parenStack + reverse(l:openers)
    let a:result.parenTrailOpeners = []

    s:RemoveWithinLine(a:result, a:result.lineNo, l:startX, l:endX)
endfunction


function! s:CorrectParenTrail(result, indentX)
    let l:parens = ''

    while len(a:result.parenStack) > 0
        let l:opener = s:Peek(a:result.parenStack)
        if l:opener.x >= a:indentX
            let a:result.parenStack = s:Pop(a:result.parenStack)
            let l:parens = l:parens . s:PARENS[l:opener.ch]
        else
            break
        endif
    endwhile

    s:InsertWithinLine(a:result, a:result.parenTrailLineNo, a:result.parenTrailStartX, l:parens)
endfunction


function! s:CleanParenTrail(result)
    let l:startX = a:result.parenTrailStartX
    let l:endX = a:result.parenTrailEndX

    if l:startX == l:endX || a:result.lineNo != a:result.parenTrailLineNo
        return
    endif

    let l:line = a:result.lines[a:result.lineNo]
    let l:newTrail = ''
    let l:spaceCount = 0
    let l:i = l:startX
    while l:i < l:endX
        if s:IsCloseParen(l:line[l:i])
            let l:newTrail = l:newTrail . l:line[l:i]
        else
            let l:spaceCount = l:spaceCount + 1
        endif
        let l:i = l:i + 1
    endwhile

    if l:spaceCount > 0
        s:ReplaceWithinLine(a:result, a:result.lineNo, l:startX, l:endX, l:newTrail)
        let a:result.parenTrailEndX = a:result.parenTrailEndX - l:spaceCount
    endif
endfunction


function! s:AppendParenTrail(result)
    let l:opener = a:result.parenStack[-1]
    let a:result.parenStack = s:Pop(a:result.parenStack)
    let l:closeCh = s:PARENS[l:opener.ch]

    let a:result.maxIndent = l:opener.x
    s:InsertWithinLine(a:result, a:result.parenTrailLineNo, a:result.parenTrailEndX, l:closeCh)
    let a:result.parenTrailEndX = a:result.parenTrailEndX + 1
endfunction

function! s:FinishNewParenTrail(result)
    if a:result.mode ==# s:INDENT_MODE
        s:ClampParenTrailToCursor(a:result)
        s:RemoveParenTrail(a:result)
    elseif a:result.mode ==# s:PAREN_MODE
        if a:result.lineNo != a:result.cursorLine
            s:CleanParenTrail(a:result)
        endif
    endif
endfunction

""------------------------------------------------------------------------------
"" Indentation functions
""------------------------------------------------------------------------------

function! s:CorrectIndent(result)
    let l:origIndent = a:result.x
    let l:newIndent = l:origIndent
    let l:minIndent = 0
    let l:maxIndent = a:result.maxIndent

    let l:opener = s:Peek(a:result.parenStack)
    if l:opener != s:SENTINEL_NULL
        let l:minIndent = l:opener.x + 1
        let l:newIndent = l:newIndent + l:opener.indentDelta
    endif

    let l:newIndent = s:Clamp(l:newIndent, l:minIndent, l:maxIndent)

    if l:newIndent != l:origIndent
        let l:indentStr = s:RepeatString(s:BLANK_SPACE, l:newIndent)
        s:ReplaceWithinLine(a:result, a:result.lineNo, 0, l:origIndent, l:indentStr)
        let a:result.x = l:newIndent
        let a:result.indentDelta = a:result.indentDelta + l:newIndent - l:origIndent
    endif
endfunction


function! s:OnProperIndent(result)
    let a:result.trackingIndent = 0

    if a:result.quoteDanger
        "" TODO: figure out throw
        "" throw error(result, ERROR_QUOTE_DANGER, SENTINEL_NULL, SENTINEL_NULL);
    endif

    if a:result.mode ==# s:INDENT_MODE
        s:CorrectParenTrail(a:result, a:result.x)
    elseif a:result.mode ==# s:PAREN_MODE
        s:CorrectIndent(a:result)
    endif
endfunction


function! s:OnLeadingCloseParen(result)
    let a:result.skipChar = 1
    let a:result.trackingIndent = 1

    if a:result.mode ==# s:PAREN_MODE
        if s:IsValidCloseParen(a:result.parenStack, a:result.ch)
            if s:IsCursorOnLeft(a:result)
                let a:result.skipChar = 0
                s:OnProperIndent(a:result)
            else
                s:AppendParenTrail(a:result)
            endif
        endif
    endif
endfunction


function! s:OnIndent(result)
    if s:IsCloseParen(a:result.ch)
        s:OnLeadingCloseParen(a:result)
    elseif a:result.ch ==# s:SEMICOLON
        let a:result.trackingIndent = 0
    elseif a:result.ch !=# s:NEWLINE
        s:OnProperIndent(a:result)
    endif
endfunction


""------------------------------------------------------------------------------
"" High-level processing functions
""------------------------------------------------------------------------------

function! s:ProcessChar(result, ch)
    let l:origCh = a:ch

    let a:result.ch = a:ch
    let a:result.skipChar = 0

    if a:result.mode ==# s:PAREN_MODE
        s:HandleCursorDelta(a:result)
    endif

    if a:result.trackingIndent && a:ch !=# s:BLANK_SPACE && a:ch !=# s:TAB
        s:OnIndent(a:result)
    endif

    if a:result.skipChar
        let a:result.ch = ''
    else
        s:OnChar(a:result)
        s:UpdateParenTrailBounds(a:result)
    endif

    s:CommitChar(a:result, l:origCh)
endfunction


function! s:ProcessLine(result, line)
    s:InitLine(a:result, a:line)

    if a:result.mode ==# s:INDENT_MODE
        let a:result.trackingIndent = len(a:result.parenStack) != 0 &&
                                    \ ! a:result.isInStr
    elseif a:result.mode ==# s:PAREN_MODE
        let a:result.trackingIndent = ! a:result.isInStr
    endif

    let l:i = 0
    let l:chars = a:line . s:NEWLINE
    while l:i < strlen(l:chars)
        s:ProcessChar(a:result, l:chars[l:i])
        let l:i = l:i + 1
    endwhile

    if a:result.lineNo == a:result.parenTrailLineNo
        s:FinishNewParenTrail(a:result)
    endif
endfunction


function! s:FinalizeResult(result)
    if a:result.quoteDanger
        "" TODO: figure out throw here
        "" throw error(result, ERROR_QUOTE_DANGER, SENTINEL_NULL, SENTINEL_NULL)
    endif

    if a:result.isInStr
        "" TODO: figure out throw here
        "" throw error(result, ERROR_UNCLOSED_QUOTE, SENTINEL_NULL, SENTINEL_NULL)
    endif

    if len(a:result.parenStack) != 0
        if a:result.mode ==# s:PAREN_MODE
            let l:opener = s:Peek(a:result.parenStack)
            "" TODO: figure out throw here
            "" throw error(result, ERROR_UNCLOSED_PAREN, opener.lineNo, opener.x);
        elseif a:result.mode ==# s:INDENT_MODE
            s:CorrectParenTrail(a:result, 0)
        endif
    endif
    let a:result.success = 1
endfunction


function! s:ProcessError(result, err)
    let a:result.success = 0
    let a:result.error = a:err
endfunction


function! s:ProcessText(text, mode, options)
    let l:result = s:CreateInitialResult(a:text, a:mode, a:options)

    "" TODO: figure out try here
    let l:i = 0
    while l:i < len(l:result.origLines)
        s:ProcessLine(l:result, l:result.origLines[l:i])
        let l:i = l:i + 1
    endwhile
    s:FinalizeResult(l:result)
    "" TODO: catch here

    return l:result
endfunction

function! s:PublicResult(result)
    if ! a:result.success
        return {
          \ 'success': 0,
          \ 'text': a:result.origText,
          \ 'error': a:result.error,
          \ }
    endif
    return {
      \ 'success': 1,
      \ 'text': join(a:result.lines, s:NEWLINE),
      \ }
endfunction

""------------------------------------------------------------------------------
"" Public API
""------------------------------------------------------------------------------

let s:PublicAPI = {}
let g:ParinferLib = s:PublicAPI

function! s:PublicAPI.IndentMode(text, options)
    let l:result = s:ProcessText(a:text, s:INDENT_MODE, a:options)
    return s:PublicResult(l:result)
endfunction

function! s:PublicAPI.ParenMode(text, options)
    let l:result = s:ProcessText(a:text, s:PAREN_MODE, a:options)
    return s:PublicResult(l:result)
endfunction
