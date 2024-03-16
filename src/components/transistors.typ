#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#import "/src/components/arrows.typ": currarrow

#let transistor(
  name,
  func,
  style,
  inputs
) = component(
  ("transistors", name),
  style => {
    let height = style.height/2
    set-style(stroke: style.stroke)

    anchor(
      "centergap",
      (
        -style.width * style.base-width + style.at("gate-width", default: 0) * 0.5,
        0
      )
    )
    anchor("left", (-style.width, 0))
    anchor("right", (0,0))
    anchor("text", (0.05, 0))
    anchor("pathstart", (0, -height))
    anchor("pathend", (0, height))

    anchor("B", (-style.width, style.conn-height * height * style.curr-direction))
    anchor("nobase", (-style.width * style.base-width, 0))
    anchor("E", (0, -height * style.curr-direction))
    anchor("C", (0, height * style.curr-direction))
    
    anchor("S", "E")
    anchor("D", "C")
    anchor("G", "B")

    func(style)

    if name != "nmos" or style.mos-arrows {
      // panic(style.arrow-pos)
      let is-end-pos = style.arrow-pos == "end"
      currarrow(
        (name: "arrow-line", anchor: style.arrow-pos),
        anchor: if is-end-pos { "tip" },
        rotate: "arrow-line." + if is-end-pos { "start" } else { "end" },
        invert: is-end-pos
      )
    }
  },
  (
    (
      stroke: auto,
      fill: auto,
      scale: auto,
      thickness: auto,

      base-width: auto,
      height: auto,
      width: auto,
      curr-direction: auto,
      component-text: "left",
      arrow-pos: auto
    ),
    style
  ),
  ..inputs
)

#let npn(..inputs) = transistor(
  "npn",
  style => {
    let height = style.height/2
    let base-x = style.base-width * -style.width
    let base-y = style.base-height * height
    let base-y-2 = style.base-height-2 * height

    anchor("inner up", (0, base-y))
    anchor("inner down", (0, -base-y))
    anchor("arrows", (base-x + 0.6 * -style.width, height * 0.2))

    line(
      "C",
      "inner up",
      (base-x, base-y-2)
    )

    line(
      (base-x, base-y),
      (base-x, -base-y)
    )

    line(
      (base-x, -base-y-2),
      "inner down",
      name: "arrow-line"
    )

    line(
      (),
      "E",
    )

    line("B", "nobase")
  },
  (
    width: .6,
    base-height: .45,
    base-height-2: .15,
    conn-height: 0,
    height: 1.1,
    base-width: .5,
    arrow-pos: 50%,
    curr-direction: 1
  ),
  inputs
)

#let nmos(..inputs) = transistor(
  "nmos",
  style => {
    let height = style.height/2
    let width = -style.width
    let base-x = width * style.base-width
    let base-y = height * style.base-height
    let gate-x = width * style.gate-width
    let gate-y = height * style.gate-height
    anchor("inner up", (0, gate-y))
    anchor("inner down", (0, -gate-y))

    line("pathend", "inner up", (base-x, gate-y))
    
    line((base-x, -gate-y), "inner down", name: "arrow-line")
    line((), "pathstart")
    line((gate-x, 0), (width, 0))


    set-style(stroke: (thickness: style.stroke.thickness * style.thickness))
    line((base-x, base-y), (base-x, -base-y))
    line((gate-x, gate-y), (gate-x, -gate-y))
  },
  (
    arrow-pos: 60%,
    base-height: 0.5,
    base-width: 0.5,
    conn-height: 0,
    gate-height: 0.35,
    gate-width: 0.62,
    height: 1.1,
    width: 0.7,
    curr-direction: 1,
    mos-arrows: false,
  ),
  inputs
)