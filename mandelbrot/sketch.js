import init, { render_data } from "./pkg/mandelbrot.js";

export function set_canvas_data(callback) {
  let canvas = document.getElementById("canvas");
  let ctx = canvas.getContext("2d");

  let imageData = ctx.getImageData(0, 0, 800, 600);

  callback(imageData.data)

  ctx.putImageData(imageData, 0, 0);
}

function showThingy(scale) {
  render_data(scale)
  
  requestAnimationFrame(() => showThingy(scale * 0.99))
}

(async () => {
  await init()
  
  showThingy(1);
})()
