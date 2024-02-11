#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

#import cetz.draw: *

#let ground(..inputs) = component(
  "ground",
  (style) => {
    line(
      (0,0),
      (0, -1.2 * style.width),
      stroke: style.stroke
    )

    style.stroke.thickness *= style.thickness
    line(
      (-0.6 * style.width, -1.2 * style.width),
      (0.6 * style.width, -1.2 * style.width),
      stroke: style.stroke
    )
    line(
      (-0.4 * style.width, -1.4 * style.width),
      (0.4 * style.width, -1.4 * style.width),
      stroke: style.stroke
    )
    line(
      (-0.25 * style.width, -1.6 * style.width),
      (0.25 * style.width, -1.6 * style.width),
      stroke: style.stroke
    )
  },
  (
    scale: auto,
    thickness: 1,
    connection-thickness: 1,
    width: .25,
    stroke: auto,
    fill: none
  ),
  ..inputs
)