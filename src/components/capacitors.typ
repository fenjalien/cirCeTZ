#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

#import cetz.draw: *

#let capacitors(
  name,
  func,
  style,
  inputs
) = component(
  ("capacitors", name),
  style => {
    anchor("text", (
      style.label.first() * -0.5,
      style.label.last()
    ))
    anchor("a", (-style.width * 0.5, -style.height * 0.5))
    anchor("b", (style.width * 0.5, style.height * 0.5))

    set-style(stroke: style.stroke)
    func(style)

  },
  (
    (
      scale: auto,
      fill: none,
      stroke: auto,
      thickness: auto
    ),
    style
  ),
  ..inputs
)

#let capacitor(..inputs) = capacitors(
  "capacitor",
  style => {
    set-style(stroke: (thickness: style.stroke.thickness * style.thickness))
    let width = style.width / 2
    let height = style.height / 2
    line(
      (-width, -height),
      (-width, height)
    )
    line(
      (width, height),
      (width, -height)
    )
  },
  (
    height: 0.6,
    width: 0.2
  ),
  inputs
)