#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

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
  },
  (
    stroke: auto
  ),
  ..inputs
)

#let isource(..inputs) = component(
  "isource",
  (style) => {
    import cetz.draw: *
    circle((0, 0), radius: 0.5)
    anchor("a", (-0.5, -0.5))
    anchor("b", (0.5, 0.5))
    if style.style.current == "european" {
      line((0, 0.5), (0, -0.5))
    } else if style.style.current == "american" {
      
    }
  },
  (
    stroke: auto,
    fill: auto,
    style: (current: auto),
  ),
  ..inputs
)

#let currarrow(..inputs) = component(
  "currarrow",
  (style) => {
    import cetz.draw: *
    line(
      fill: black,
      close: true,
      (0.05, 0),
      (-0.05, -0.05),
      (-0.05, 0.05),
    )
  },
  (
    fill: auto,
  ),
  ..inputs
)