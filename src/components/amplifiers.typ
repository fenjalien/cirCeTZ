#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let op-amp(..inputs) = component(
  "op-amp",
  (style) => {
    let step = (style.width * style.port-width) / 2
    let input-height = style.height/2 * style.input-height
    anchor("out", (style.width/2, 0))
    anchor("bout", (step, 0))
    anchor("in up", (-style.width/2, input-height))
    anchor("+", "in up")
    anchor("in down", (-style.width/2, -input-height))
    anchor("-", "in down")
    anchor("bin up", (-step, input-height))
    anchor("bin down", (-step, -input-height))
    anchor(
      "text",
      (if style.component-text == "left" { -step } else { 0 }, 0)
    )

    // triangle
    line(
      (-step, style.height/2),
      "bout",
      (-step, -style.height/2),
      close: true,
      fill: style.fill,
      stroke: style.stroke + (thickness: style.stroke.thickness * style.thickness)
    )

    // - input
    line(
      "bin up",
      "in up",
      stroke: style.stroke
    )

    // + input
    line(
      "bin down",
      "in down",
      stroke: style.stroke
    )

    // output
    line(
      "bout",
      "out",
      stroke: style.stroke
    )


    content("bin up", $ + $, anchor: "west", padding: 0.1)
    content("bin down", $ - $, anchor: "west", padding: 0.1)

  },
  (
    fill: auto,
    stroke: auto,
    thickness: auto,
    scale: auto,
    width: 1.7,
    height: 1.4,
    input-height: .5,
    port-width: .7,
    component-text: auto
  ),
  ..inputs
)