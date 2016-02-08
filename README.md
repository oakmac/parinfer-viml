# Parinfer in Vimscript

A [Parinfer] implementation in [Vimscript].

## About

Having a Parinfer implementation written in Vimscript allows Parinfer to reach
vi-based editors easily.

Please note that this project is solely for the library that implements the core
Parinfer algorithm; it is not a vi extension that can be used for editing.

This is basically a 1-to-1 port of [parinfer.js].

The `.json` files in the [tests] folder are copied directly from the [main
Parinfer repo].

This is my first Vim script project. There is likely lots of room for
improvement in this implementation. PR's welcome :)

## Usage

TODO: write this

## Run Tests

TODO: write this

## License

[ISC License]

[Parinfer]:https://shaunlebron.github.io/parinfer/
[Vimscript]:https://en.wikipedia.org/wiki/Vim_(text_editor)#Vim_script
[parinfer.js]:https://github.com/shaunlebron/parinfer/blob/master/lib/parinfer.js
[tests]:tests/
[main Parinfer repo]:https://github.com/shaunlebron/parinfer/tree/master/lib/test/cases
[parinfer.js API]:https://github.com/shaunlebron/parinfer/tree/master/lib#api
[ISC License]:LICENSE.md
