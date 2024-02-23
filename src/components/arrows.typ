#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

#import cetz.draw: *


#let currarrow(..inputs) = component(
  "currarrow",
  (style) => {
    let scale = 1/style.current-arrow-scale
    anchor("a", (-0.7 * scale, -0.8 * scale))
    anchor("b", (0.7 * scale, 0.8 * scale))
    anchor("tip", (scale, 0))
    line(
      fill: style.fill,
      stroke: none,
      close: true,
      "a",
      "tip",
      ("a", "|-", "b")
      // (-0.7 * scale, 0.8 * scale),
    )
  },
  (
    fill: black,
    stroke: auto,
    current-arrow-scale: 16
  ),
  ..inputs
)
