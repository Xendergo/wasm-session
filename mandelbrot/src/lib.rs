use js_sys::Uint8ClampedArray;
use wasm_bindgen::prelude::*;

#[wasm_bindgen(raw_module = "/sketch.js")]
extern "C" {
    fn set_canvas_data(s: &Closure<dyn FnMut(Uint8ClampedArray) -> ()>);
}

#[wasm_bindgen]
pub fn render_data(scale: f64) {
    let mut data = vec![0; 800 * 600 * 4];

    let count = (10. * (1. / scale).ln()) as usize + 30;

    for x in 0..800 {
        for y in 0..600 {
            let shade = mandelbrot_shade_at_pos(
                (
                    (x as f64 - 400.) / 200. * scale - 1.5,
                    (y as f64 - 300.) / 200. * scale,
                ),
                count,
            );

            data[4 * (x + y * 800) + 0] = (shade * 256.) as u8;
            data[4 * (x + y * 800) + 1] = (shade * 256.) as u8;
            data[4 * (x + y * 800) + 2] = (shade * 256.) as u8;
            data[4 * (x + y * 800) + 3] = 255;
        }
    }

    set_canvas_data(&Closure::once(move |array: Uint8ClampedArray| {
        array.copy_from(&data)
    }));
}

fn mandelbrot_shade_at_pos(c: (f64, f64), count: usize) -> f64 {
    let mut z = (0., 0.);

    for i in 0..count {
        if z.0 * z.0 + z.1 * z.1 > 4. {
            return i as f64 / count as f64;
        }

        z = (z.0 * z.0 - z.1 * z.1 + c.0, z.0 * z.1 * 2. + c.1);
    }

    return 1.;
}
