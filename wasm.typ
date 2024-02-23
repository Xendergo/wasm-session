#import "@local/henrys-typst-utils:0.1.0" : *
#import "@preview/polylux:0.3.1": *

#import code-theme: *

#show: code-theme

#title-slide(title: [How 2 Webassembly], author: [Henry Rovnyak], note: [Go to *TODO: PUT GITHUB LINK HERE* and follow the setup instructions if you want to follow along])

#mono-slide(title: [What am I talking about?], content:[
    - What is webassembly?
    - How can I use it?
    - But I'm a crazy person! How do I \*really\* use it?
])

#split-slide(title: [What am I not talking about?], content: [
    - Leptos
    - Yew
    - Blazor
    - Vugu
    - etc.
], picture: {
set text(size: 18pt)
```rust // Stolen from the Leptos book
#[component]
fn App() -> impl IntoView {
    let (count, set_count) = create_signal(0);

    view! {
        <button
            on:click=move |_| {
                set_count(3);
            }
        >
            "Click me: "
            {move || count()}
        </button>
    }
}```})

#split-slide(title: [How do websites work?], content: [
    - HTML: Hypertext Markup Language
        - What to show
        - Requests resources

    - CSS: Cascading Style Sheets
        - How the website should look

    - Javascript
        - What the website should do
], picture: {
    set text(18pt)
    [index.html:]
    ```html
    <!doctype html>

    <html>
      <head>
        <title>Mandelbrot</title>
      </head>

      <body>
        <canvas id="canvas" width="800" height="600"></canvas>
        <script type="module" src="sketch.js"></script>
      </body>
    </html>
    ```
})

#split-slide(title: [What problems does Webassembly solve?], content: [
    #pdfpc.speaker-note("")

    - Javascript is a bad language
        - Cursed
        - No type checking
        - Slow
    - Running stuff on the web that was not meant for the web
], picture: {
    image("slideshow-images/js-strongtyped.png")
    set text(25pt)
    ```javascript
        "0" == 0  // true
         0  == [] // true
        "0" == [] // false???
    ```
}, content-width: 1.2fr)

#mono-slide(title: [What is Webassembly?], content: [
    - Similar to assembly/machine code
    - Compilation target for other languages
    - Small instruction set
    - Interfaces with Javascript
    - Needs Javascript glue code
    - No access to the standard library
])

#mono-slide(title: [Demo 1!], content: [
    - Mandelbrot set
        - You should already have everything set up if you want to follow along
], )

#mono-slide(title: [Now observe this Meme], content: box(align(center, image("slideshow-images/earthquack.png")), width: 100%, height: 83%))

#mono-slide(title: [I know what you're thinking...], content: {
    set text(40pt)
    v(20%)
    uncover(2,
        grid(rows: 3, gutter: 25pt, [W], [A], [T])
    )
})

#mono-slide(title: [And you'd be right!], content: {
    set text(40pt)
    v(20%)
    grid(rows: 3, gutter: 25pt, [Web], [Assembly], [Text])
})

#split-slide(title: [Sections], content: [
    - Globally accessable stuff
        - Memory
        - Globals
        - Imports
        - Exports
        - Functions
        - etc.
], picture: [
    #set text(15pt)
    ```wat
    (module
        	(memory (import "js" "mem") 1)
        	(global $end_of_input (import "js" "endOfInput") i32)

        	(import "console" "log" (func $log (param i32) (result i32)))
        	(import "js" "parseNum" (func $parse_num (param i32) (result i32)))

        	(func (export "solve") (result i32)
             ; ...
          )
    )
    ```
])

#mono-slide(title: [Instructions/Execution], content: [
    - Small instruction set
    - Mix of stack and register based
    - Higher level control flow constructs
])

#mono-slide(title: [Demo!], content: [
    https://adventofcode.com/2023/day/4
])
