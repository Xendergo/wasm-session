#import "@local/henrys-typst-utils:0.1.0" : *

= Title

So you're writing a website, right? And you're just thinking to yourself \"Wow, javascript really sucks, I wish I could be using anything else right now.\" Well guess what, you can, and it's called webassembly, and I'm going to teach you all about it in tonights session.

= What am I talking about?

So what will I be talking about?

- What is webassembly?
- Rust
    - Mandelbrot set
- Raw
    - for crazy people or you want to learn fundamentals
    - AoC day 4

= What am I not talking about?

First, what I won't be talking about are...

- Batteries included frameworks
    - Compiles your code into webassembly
    - Abstract away webassembly into a technical detail
- I'm teaching webassembly, not a framework
- Super useful if you want to make a whole website in webassembly

= How do websites work?

So first, how do websites work?

1. Put an address into your browser
2. Browser makes HTTP request
3. Returns an HTML file
    - Content of the webpage
    - Example on the right
    - Instructs the browser to download additional files
- CSS
    - How your website looks
- Javascript
    - Programming language
    - What the website should do
    - Ex: Making scrolling do something other than actually scrolling

= What problems does Webassembly solve?

So where does webassembly fit into this? Before that I need to explain what problems webassembly attempts to solve.

- Javascript is cursed
    - You can compare strings and numbers and it might return true
    - Added a triple equals operator when people figured out that made no sense
    - No type checking

- Scripting language; Slow as heck
    - No rendering fractals

- Running non-web stuff on the web
    - FFMPEG
    - Your browser doesn't understand assembly

So for these reasons, developers invented Webassembly.
    
= What is Webassembly?

So now, what is webassembly? 

- Standardized machine code
    - Compilation target for other languages
    - You're not meant to code in it directly, but you totally can and we will
    - You can write code for the web in any language you like
    - Compiling desktop programs for the web

- Can only interface with javascript
    - Importing and exporting functions from/to javascript

- Can't send or receive complex data structures, only numbers
    - You need javascript to encode and decoded data directly in your webassembly module's memory
    - "Glue code"
        - We'll use Rust for our first demo and we'll see that it takes care of this for us.

- No direct access to DOM or standard library
    - You need to import from Javascript
    - Also taken care of by Rust

= Demo 1!

So now we can start with the first demo!

- Mandelbrot set
    - I'm assuming that if you wanted to follow along you set everything up in accordance with the README on the github page.
