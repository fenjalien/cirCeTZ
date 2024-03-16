#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

#import cetz.draw: *

#let logic-port(
  name,
  func,
  style,
  ..inputs
) = component(
  ("logic-ports", name),
  style => {
    style.height *= 0.5 * style.baselen
    style.pin-length *= style.baselen
    style.not-radius *= style.height
    anchor("left", (-8 * style.height / 6.5, 0))
    anchor("right", (8 * style.height / 6.5, 0))
    

    func(style)
  },
  (
    (
      baselen: 0.4,
      pin-length: 0.7,
      height: 2,
      scale: auto,
      stroke: auto,
      fill: white,
      thickness: auto,
      not-radius: 0.154
    ),
    style
  ),
  ..inputs
)

#let notcirc = logic-port.with(
  "notcirc", 
  style => {
    style.stroke.thickness *= style.thickness
    circle((), radius: style.not-radius, stroke: style.stroke, fill: style.fill)
  },
  (
    stroke: auto
  )
)

#let and-port = logic-port.with(
  "and-port",
  style => {
    let height = style.height

    line(())

    style.stroke.thickness *= style.thickness
    merge-path({
      line(
        (-8 * height / 6.5, height),
        (1.5 * height / 6.5, height)
      )
      arc((), start: 90deg, stop: -90deg, radius: height)
      line((), 
        (-8 * height / 6.5, -height)
      )
    }, close: true, stroke: style.stroke)

  },
  (
    stroke: auto,
  )
)