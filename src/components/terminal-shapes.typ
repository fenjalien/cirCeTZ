#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

#import cetz.draw: *

#let circ(..inputs) = component(
  "circ",
  (style) => {
    circle(
      (0, 0),
      radius: style.nodes-width,
      stroke: style.stroke,
      fill: style.fill
    )
  },
  (
    stroke: none,
    fill: black,
    nodes-width: 0.04
  ),
  ..inputs
)