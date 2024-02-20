# WebAssembly Session

This repository contains the slides, notes, and code for my webassembly session for Purdue Hackers.

# Setup to follow along

**NOTE: If these instructions don't work for you, come and find me during hack night or message me on discord!**

You will need a tool that can run a static web server locally on your computer.

On some systems,

```bash
python3 -m http.server
```

will just work and you're all set. If it doesn't work, you can install python3. Another option would be the `vscode-preview-server` extension for VS code or to script something yourself. Further instructions are available on [MDN](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/Tools_and_setup/set_up_a_local_testing_server).

## Rust demo setup

1. Go to [https://rustup.rs/](https://rustup.rs/) and follow the instructions to install Rust on your computer.
2. Run `cargo install wasm-pack` to install the tools needed to compile to webassembly
3. `cd` into `mandelbrot` and run `wasm-pack build --target web` to compile the webassembly module. If this command succeeds, you have everything installed correctly.
4. Run `python3 -m http.server` to start a local server and go to `localhost:8000`. You should see a fancy fractal zoom, right in your browser! If you chose an alternative method to start a local server, the port number (the number after the colon) may be different. 

## WAT aka "raw webassembly" demo setup

1. Check if something like `wabt` exists in your package manager of choice. If so, install it.
2. Go to [https://github.com/webassembly/wabt](https://github.com/webassembly/wabt?tab=readme-ov-file#building-using-cmake-directly-linux-and-macos) and follow the instructions to build the program. Then add `*clone-directory*/wabt/out/clang/Debug` to your system path so you can type `wat2wasm` instead of the full path to it. Do that however your operating system does that; google or me can help you if you need.
3. cd into `scratchcards` and run `wat2wasm solution.wat` to assemble the wat code into wasm.
4. Start a local server in `scratchcards` and go to the localhost address. You should see `26218` on the screen; that means it worked! If the number's `13`, then I changed the input data without changing the README because I'm an idiot.
