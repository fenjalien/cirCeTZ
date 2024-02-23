#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

#import cetz.draw: *

#let short(..inputs) = component(
  "short",
  (style) => {
    // anchor("a", (0.05, 0.05))
    // anchor("b", (-0.05, -0.05))
  },
  (
    stroke: auto
  ),
  ..inputs
)

#let resistor(..inputs) = component(
  "resistor",
  (style) => {
    let step = style.width / (style.zigs * 2)
    let height = style.height
    let sgn = -1
    let x = style.width / 2
    style.stroke.thickness *= style.thickness
    line(
      (-x, 0),
      (rel: (step/2, height/2)),
      ..for _ in range(style.zigs * 2 - 1) {
        ((rel: (step, height * sgn)),)
        sgn *= -1
      },
      (x, 0),
      fill: none,
      stroke: style.stroke
    )
    anchor("a", (-x, -height/2))
    anchor("b", (x, height/2))
    // anchor("text", (0, style.label.last()))
  },
  (
    stroke: auto,
    thickness: auto,
    scale: auto,
    width: 0.8,
    height: 0.3,
    zigs: 3,
  ),
  ..inputs
)