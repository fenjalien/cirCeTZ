#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

#import cetz.draw: *

#let short(..inputs) = component(
  "short",
  (style) => {
    let pos = 0.5
    line((-pos, 0), (pos, 0))
    anchor("a", (-pos, 0.001))
    anchor("b", (pos, -0.001))
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
    line(
      (-x, 0),
      (rel: (step/2, height/2)),
      ..for _ in range(style.zigs * 2 - 1) {
        ((rel: (step, height * sgn)),)
        sgn *= -1
      },
      (x, 0),
      fill: none,
      // stroke: (join: "round")
    )
    anchor("a", (-x, -height/2))
    anchor("b", (x, height/2))
  },
  (
    stroke: auto,
    thickness: auto,
    width: 0.8,
    height: 0.3,
    zigs: 3,
  ),
  ..inputs
)