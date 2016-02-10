""!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
""!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
""
"" NOTE: This file is automatically generated from build-tests-file.js
""       Please do not edit it directly
""
""!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
""!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

source parinfer.vim
let s:anyErrorsFound = 0

""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"" Indent Mode Tests
""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"" Test Id: 6
let s:result = g:ParinferLib.IndentMode("(defn foo\n  [arg\n  ret", {})
let s:expectedText = "(defn foo\n  [arg]\n  ret)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 6 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 6 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 6 failed"
endif


"" Test Id: 20
let s:result = g:ParinferLib.IndentMode("(defn foo\n  [arg\n   ret", {})
let s:expectedText = "(defn foo\n  [arg\n   ret])"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 20 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 20 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 20 failed"
endif


"" Test Id: 34
let s:result = g:ParinferLib.IndentMode("(defn foo\n[arg\n   ret", {})
let s:expectedText = "(defn foo)\n[arg\n   ret]"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 34 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 34 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 34 failed"
endif


"" Test Id: 48
let s:result = g:ParinferLib.IndentMode("(defn foo\n[arg\nret", {})
let s:expectedText = "(defn foo)\n[arg]\nret"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 48 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 48 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 48 failed"
endif


"" Test Id: 62
let s:result = g:ParinferLib.IndentMode("(defn foo\n  [arg\n  ret\n\n(defn foo\n  [arg\n  ret", {})
let s:expectedText = "(defn foo\n  [arg]\n  ret)\n\n(defn foo\n  [arg]\n  ret)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 62 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 62 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 62 failed"
endif


"" Test Id: 86
let s:result = g:ParinferLib.IndentMode("(def foo [a b]]", {})
let s:expectedText = "(def foo [a b])"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 86 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 86 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 86 failed"
endif


"" Test Id: 96
let s:result = g:ParinferLib.IndentMode("(let [x {:foo 1 :bar 2]\n  x)", {})
let s:expectedText = "(let [x {:foo 1 :bar 2}]\n  x)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 96 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 96 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 96 failed"
endif


"" Test Id: 110
let s:result = g:ParinferLib.IndentMode("(def foo \"as", {})
let s:expectedText = "(def foo \"as"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 110 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 110 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 110 failed"
endif


"" Test Id: 120
let s:result = g:ParinferLib.IndentMode("(defn foo [a \"])", {})
let s:expectedText = "(defn foo [a \"])"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 120 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 120 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 120 failed"
endif


"" Test Id: 130
let s:result = g:ParinferLib.IndentMode("(defn foo\n  \"This is docstring.\n  Line 2 here.\"\n  ret", {})
let s:expectedText = "(defn foo\n  \"This is docstring.\n  Line 2 here.\"\n  ret)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 130 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 130 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 130 failed"
endif


"" Test Id: 146
let s:result = g:ParinferLib.IndentMode("(let [a \"Hello\nWorld\"\n      b 2\n  ret", {})
let s:expectedText = "(let [a \"Hello\nWorld\"\n      b 2]\n  ret)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 146 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 146 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 146 failed"
endif


"" Test Id: 162
let s:result = g:ParinferLib.IndentMode("(let [a \"])\"\n      b 2", {})
let s:expectedText = "(let [a \"])\"\n      b 2])"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 162 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 162 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 162 failed"
endif


"" Test Id: 174
let s:result = g:ParinferLib.IndentMode("(def foo \"\\\"\"", {})
let s:expectedText = "(def foo \"\\\"\")"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 174 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 174 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 174 failed"
endif


"" Test Id: 191
let s:result = g:ParinferLib.IndentMode("\"\"]\"", {'cursorX':1,'cursorLine':0,})
let s:expectedText = "\"\"]\""
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {'cursorX':1,'cursorLine':0,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 191 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 191 failed"
endif


"" Test Id: 201
let s:result = g:ParinferLib.IndentMode("(def foo\n  \"\n  \"(a b)\n      c\")", {'cursorX':3,'cursorLine':1,})
let s:expectedText = "(def foo\n  \"\n  \"(a b)\n      c\")"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {'cursorX':3,'cursorLine':1,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 201 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 201 failed"
endif


"" Test Id: 224
let s:result = g:ParinferLib.IndentMode("(for [col columns]\n  \"\n  [:div.td {:style \"max-width: 500px;\"}])", {'cursorX':3,'cursorLine':1,})
let s:expectedText = "(for [col columns]\n  \"\n  [:div.td {:style \"max-width: 500px;\"}])"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {'cursorX':3,'cursorLine':1,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 224 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 224 failed"
endif


"" Test Id: 240
let s:result = g:ParinferLib.IndentMode("(def foo [a b]\n  ; \"my multiline\n  ; docstring.\"\nret)", {})
let s:expectedText = "(def foo [a b])\n  ; \"my multiline\n  ; docstring.\"\nret"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 240 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 240 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 240 failed"
endif


"" Test Id: 256
let s:result = g:ParinferLib.IndentMode("(def foo [a b]\n  ; \"\"\\\"\nret)", {})
let s:expectedText = "(def foo [a b])\n  ; \"\"\\\"\nret"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 256 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 256 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 256 failed"
endif


"" Test Id: 272
let s:result = g:ParinferLib.IndentMode("(defn foo [a b\n  \\[\n  ret", {})
let s:expectedText = "(defn foo [a b]\n  \\[\n  ret)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 272 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 272 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 272 failed"
endif


"" Test Id: 287
let s:result = g:ParinferLib.IndentMode("(def foo \\;", {})
let s:expectedText = "(def foo \\;)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 287 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 287 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 287 failed"
endif


"" Test Id: 297
let s:result = g:ParinferLib.IndentMode("(def foo \\,\n(def bar \\ ", {})
let s:expectedText = "(def foo \\,)\n(def bar \\ )"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 297 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 297 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 297 failed"
endif


"" Test Id: 309
let s:result = g:ParinferLib.IndentMode("(foo [a b\\\n  c)", {})
let s:expectedText = "(foo [a b\\\n  c)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 309 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 309 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 309 failed"
endif


"" Test Id: 324
let s:result = g:ParinferLib.IndentMode("(def foo ;)", {})
let s:expectedText = "(def foo) ;)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 324 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 324 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 324 failed"
endif


"" Test Id: 335
let s:result = g:ParinferLib.IndentMode("(let [a 1\n      b 2\n      c {:foo 1\n         ;; :bar 2}]\n  ret)", {})
let s:expectedText = "(let [a 1\n      b 2\n      c {:foo 1}]\n         ;; :bar 2}]\n  ret)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 335 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 335 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 335 failed"
endif


"" Test Id: 353
let s:result = g:ParinferLib.IndentMode("(let [a 1 ;; a comment\n  ret)", {})
let s:expectedText = "(let [a 1] ;; a comment\n  ret)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 353 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 353 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 353 failed"
endif


"" Test Id: 365
let s:result = g:ParinferLib.IndentMode("; hello \\n world", {})
let s:expectedText = "; hello \\n world"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 365 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 365 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 365 failed"
endif


"" Test Id: 382
let s:result = g:ParinferLib.IndentMode("(def b )", {'cursorX':7,'cursorLine':0,})
let s:expectedText = "(def b )"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {'cursorX':7,'cursorLine':0,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 382 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 382 failed"
endif


"" Test Id: 392
let s:result = g:ParinferLib.IndentMode("(def b )", {})
let s:expectedText = "(def b)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 392 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 392 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 392 failed"
endif


"" Test Id: 402
let s:result = g:ParinferLib.IndentMode("(def b [[c d] ])", {'cursorX':14,'cursorLine':0,})
let s:expectedText = "(def b [[c d] ])"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {'cursorX':14,'cursorLine':0,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 402 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 402 failed"
endif


"" Test Id: 412
let s:result = g:ParinferLib.IndentMode("(def b [[c d] ])", {})
let s:expectedText = "(def b [[c d]])"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 412 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 412 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 412 failed"
endif


"" Test Id: 423
let s:result = g:ParinferLib.IndentMode("(def b [[c d] ])", {'cursorX':5,'cursorLine':0,})
let s:expectedText = "(def b [[c d]])"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {'cursorX':5,'cursorLine':0,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 423 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 423 failed"
endif


"" Test Id: 437
let s:result = g:ParinferLib.IndentMode("(let [a 1])\n  ret)", {})
let s:expectedText = "(let [a 1]\n  ret)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 437 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 437 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 437 failed"
endif


"" Test Id: 449
let s:result = g:ParinferLib.IndentMode("(let [a 1])\n  ret)", {'cursorX':11,'cursorLine':0,})
let s:expectedText = "(let [a 1])\n  ret"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {'cursorX':11,'cursorLine':0,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 449 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 449 failed"
endif


"" Test Id: 462
let s:result = g:ParinferLib.IndentMode("(let [a 1]) 2\n  ret", {})
let s:expectedText = "(let [a 1]) 2\n  ret"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 462 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 462 failed"
endif
let s:result3 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Cross-mode preservation test 462 failed"
endif


"" Test Id: 475
let s:result = g:ParinferLib.IndentMode("(let [a 1])\n  ret)", {'cursorX':10,'cursorLine':0,})
let s:expectedText = "(let [a 1]\n  ret)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {'cursorX':10,'cursorLine':0,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 475 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 475 failed"
endif


"" Test Id: 487
let s:result = g:ParinferLib.IndentMode("(let [a 1]) ;\n  ret", {'cursorX':13,'cursorLine':0,})
let s:expectedText = "(let [a 1] ;\n  ret)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {'cursorX':13,'cursorLine':0,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 487 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 487 failed"
endif


"" Test Id: 501
let s:result = g:ParinferLib.IndentMode("(let [a 1\n      ])", {'cursorX':6,'cursorLine':1,})
let s:expectedText = "(let [a 1])\n      "
let s:outText = s:result.text
let s:result2 = g:ParinferLib.IndentMode(s:outText, {'cursorX':6,'cursorLine':1,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode In/Out test 501 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Indent Mode Idempotence test 501 failed"
endif


""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"" Paren Mode Tests
""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"" Test Id: 4
let s:result = g:ParinferLib.ParenMode("(let [foo 1]\nfoo)", {})
let s:expectedText = "(let [foo 1]\n foo)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 4 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 4 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 4 failed"
endif


"" Test Id: 16
let s:result = g:ParinferLib.ParenMode("(let [foo 1]\n      foo)", {})
let s:expectedText = "(let [foo 1]\n     foo)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 16 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 16 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 16 failed"
endif


"" Test Id: 28
let s:result = g:ParinferLib.ParenMode("(let [foo {:a 1}]\n           foo)", {})
let s:expectedText = "(let [foo {:a 1}]\n     foo)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 28 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 28 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 28 failed"
endif


"" Test Id: 40
let s:result = g:ParinferLib.ParenMode("(let [foo [1 2 3]]\n      (-> foo\n          (map inc)))", {})
let s:expectedText = "(let [foo [1 2 3]]\n     (-> foo\n         (map inc)))"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 40 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 40 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 40 failed"
endif


"" Test Id: 56
let s:result = g:ParinferLib.ParenMode("(let [foo 1\n      bar 2\n\n      ] (+ foo bar\n  )\n)", {})
let s:expectedText = "(let [foo 1\n      bar 2]\n\n     (+ foo bar))\n  \n"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 56 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 56 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 56 failed"
endif


"" Test Id: 76
let s:result = g:ParinferLib.ParenMode("(def x [1 2 3 4\n         5 6 7 8])", {})
let s:expectedText = "(def x [1 2 3 4\n         5 6 7 8])"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 76 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 76 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 76 failed"
endif


"" Test Id: 88
let s:result = g:ParinferLib.ParenMode("  (assoc x\n:foo 1\n     :bar 2)", {})
let s:expectedText = "  (assoc x\n   :foo 1\n     :bar 2)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 88 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 88 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 88 failed"
endif


"" Test Id: 102
let s:result = g:ParinferLib.ParenMode("(let [foo 1]\n      foo)\n\n(let [foo 1]\nfoo)", {})
let s:expectedText = "(let [foo 1]\n     foo)\n\n(let [foo 1]\n foo)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 102 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 102 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 102 failed"
endif


"" Test Id: 120
let s:result = g:ParinferLib.ParenMode("; hello \\n world", {})
let s:expectedText = "; hello \\n world"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 120 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 120 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 120 failed"
endif


"" Test Id: 130
let s:result = g:ParinferLib.ParenMode("(def foo \\,)\n(def bar \\ )", {})
let s:expectedText = "(def foo \\,)\n(def bar \\ )"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 130 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 130 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 130 failed"
endif


"" Test Id: 142
let s:result = g:ParinferLib.ParenMode("(foo [a b\n])", {'cursorX':0,'cursorLine':1,})
let s:expectedText = "(foo [a b\n      ])"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {'cursorX':0,'cursorLine':1,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 142 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 142 failed"
endif


"" Test Id: 156
let s:result = g:ParinferLib.ParenMode("(def foo\n,bar)", {})
let s:expectedText = "(def foo\n ,bar)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 156 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 156 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 156 failed"
endif


"" Test Id: 168
let s:result = g:ParinferLib.ParenMode("(def foo [a b]\n  ; \"my string\nret)", {})
let s:expectedText = "(def foo [a b]\n  ; \"my string\nret)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 168 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 168 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 168 failed"
endif


"" Test Id: 182
let s:result = g:ParinferLib.ParenMode("(def foo [a b]\n  ; \"my multiline\n  ; docstring.\"\nret)", {})
let s:expectedText = "(def foo [a b]\n  ; \"my multiline\n  ; docstring.\"\n ret)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 182 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 182 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 182 failed"
endif


"" Test Id: 199
let s:result = g:ParinferLib.ParenMode("(foo [a b]\\\nc)", {})
let s:expectedText = "(foo [a b]\\\nc)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 199 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 199 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 199 failed"
endif


"" Test Id: 212
let s:result = g:ParinferLib.ParenMode("(foo )", {'cursorX':5,'cursorLine':0,})
let s:expectedText = "(foo )"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {'cursorX':5,'cursorLine':0,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 212 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 212 failed"
endif


"" Test Id: 220
let s:result = g:ParinferLib.ParenMode("(foo [1 2 3 ] )", {'cursorX':12,'cursorLine':0,})
let s:expectedText = "(foo [1 2 3 ] )"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {'cursorX':12,'cursorLine':0,})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 220 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 220 failed"
endif


"" Test Id: 230
let s:result = g:ParinferLib.ParenMode("(foo )", {})
let s:expectedText = "(foo)"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 230 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 230 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 230 failed"
endif


"" Test Id: 238
let s:result = g:ParinferLib.ParenMode("(foo [1 2 3 ] )", {})
let s:expectedText = "(foo [1 2 3])"
let s:outText = s:result.text
let s:result2 = g:ParinferLib.ParenMode(s:outText, {})
let s:outText2 = s:result2.text
if s:outText !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode In/Out test 238 failed"
endif
if s:outText2 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Idempotence test 238 failed"
endif
let s:result3 = g:ParinferLib.IndentMode(s:outText, {})
let s:outText3 = s:result3.text
if s:outText3 !=# s:expectedText
    let s:anyErrorsFound = 1
    silent !echo "Paren Mode Cross-mode preservation test 238 failed"
endif


""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"" Show success if there were no failures
""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if ! s:anyErrorsFound
    silent !echo "All tests passed"
    q
else
    cq
endif
