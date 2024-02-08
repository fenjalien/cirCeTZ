#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

#let sources() = {

}

#let isource(..inputs) = component(
  "isource",
  (style) => {
    import cetz.draw: *
    circle((0, 0), radius: 0.5)
    line((0, 0.5), (0, -0.5))
    anchor("a", (-0.5, -0.5))
    anchor("b", (0.5, 0.5))
  },
  (
    stroke: auto,
    fill: auto,
  ),
  ..inputs
)

#let resistor(..inputs) = component(
  "resistor",
  (style) => {
    import cetz.draw: *
    let step = 1/6
    let height = 5/14
    let sgn = -1
    line(
      (-0.5, 0),
      (rel: (step/2, height/2)),
      ..for _ in range(5) {
        ((rel: (step, height * sgn)),)
        sgn *= -1
      },
      (0.5, 0),
      fill: none
    )
    anchor("a", (-0.5, -height/2))
    anchor("b", (0.5, height/2))
    // anchor("north", (0, height/2))
    // anchor("south", (0, -height/2))
  },
  (
    stroke: auto,
    fill: auto,
  ),
  ..inputs
)