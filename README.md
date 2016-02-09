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

This is my first Vimscript project. There is likely lots of room for improvement
in this implementation. PR's welcome :)

## Usage

TODO: write this section

## Run Tests

Install [node.js]

```sh
# write the tests.vim file
node build-tests-file.js

# open vim
vim

# inside of vim, type ":source tests.vim"
# the tests will run and display errors or a success message if they all pass
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
