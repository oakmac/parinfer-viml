# Parinfer in Vimscript [![Build Status](https://travis-ci.org/oakmac/parinfer-viml.svg?branch=master)](https://travis-ci.org/oakmac/parinfer-viml)

A [Parinfer] implementation in [Vimscript].

## Project Status (Dec 2022)

I do not plan on actively maintaining this project moving forward. [parinfer-lua]
exists and is **much** faster than Vimscript. NeoVim users may wish to check out
the [nvim-parinfer] plugin or [parinfer-rust].

[parinfer-lua]:https://github.com/oakmac/parinfer-lua
[nvim-parinfer]:https://github.com/gpanders/nvim-parinfer
[parinfer-rust]:https://github.com/eraserhd/parinfer-rust

## About

Having a Parinfer implementation written in Vimscript allows Parinfer to reach
vi-based editors easily.

Please note that this project is solely for the library that implements the core
Parinfer algorithm; it is not a vi extension that can be used for editing.

This is basically a 1-to-1 port of [parinfer.js].

The `.json` files in the [tests] folder are copied directly from the [main
Parinfer repo].

This is my first Vimscript project. There is likely lots of room for improvement
in this implementation. PR's welcome :)

## Usage

TODO: write this section

## Run Tests

Install [node.js]

```sh
# write the tests.vim file
node build-tests-file.js

# run tests in vim
vim -S tests.vim
```

Run performance test:

```sh
vim -S perf.vim
```

## License

[ISC License]

[Parinfer]:https://shaunlebron.github.io/parinfer/
[Vimscript]:https://en.wikipedia.org/wiki/Vim_(text_editor)#Vim_script
[parinfer.js]:https://github.com/shaunlebron/parinfer/blob/master/lib/parinfer.js
[tests]:tests/
[main Parinfer repo]:https://github.com/shaunlebron/parinfer/tree/master/lib/test/cases
[parinfer.js API]:https://github.com/shaunlebron/parinfer/tree/master/lib#api
[node.js]:https://nodejs.org
[ISC License]:LICENSE.md
