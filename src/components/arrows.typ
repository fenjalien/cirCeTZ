#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

#import cetz.draw: *


#let currarrow(..inputs) = component(
  "currarrow",
  (style) => {
    let scale = 1/style.current-arrow-scale
    line(
      fill: style.fill,
      stroke: if style.stroke.paint != none { style.stroke },
      close: true,
      (-0.7 * scale, -0.8 * scale),
      (1 * scale, 0),
      (-0.7 * scale, 0.8 * scale),
    )
  },
  (
    fill: black,
    stroke: none,
    current-arrow-scale: 16
  ),
  ..inputs
)
