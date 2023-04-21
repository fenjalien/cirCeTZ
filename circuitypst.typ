
#import "../typst-canvas/draw.typ": *

#let subcomponents = (
  "and gate body": {
    arc((0, 0.5), 0deg, 180deg, radius: 0.5, name: "curve")
    line((), (rel: (-0.5, 0)))
    line((), (rel: (0, -1)))
    line((), (rel: (0.5, 0)))
  }
)

#let components = (
  "and gate": {
    subcomponents.at("and gate body")
    line((-0.5, -0.25), (rel: (-0.5, 0)), name: "1")
    line((-0.5, 0.25), (rel: (-0.5, 0)), name: "2")
    line((0.5, 0), (rel: (0.5, 0)), name: "3")
    anchor("in 1", "1.end")
    anchor("bin 1", "1.start")
    anchor("in 2", "2.end")
    anchor("bin 2", "2.start")
    anchor("out", "3.end")
    anchor("bout", "3.start")
  },
  "or gate": {
    arc((0.5, 0), 120deg, 180deg, name: "tcurve")
    arc((0.5, 0), 0deg, 60deg, anchor: "end", name: "bcurve")
    line("tcurve.end", (-0.5, -0.5))
    line("bcurve.start", (-0.5, 0.5))
    arc((-0.5, 0.5), 60deg, 120deg)

    // x coordinate of where the input legs touch the body of the gate
    let x = calc.cos(calc.asin(0.25)) - calc.cos(calc.asin(0.5)) - 0.5
    line((x, -0.25), (-1, -0.25), name: "1")
    line((x, 0.25), (-1, 0.25), name: "2")
    line((0.5, 0), (1, 0), name: "3")

    anchor("in 1", "1.end")
    anchor("bin 1", "1.start")
    anchor("in 2", "2.end")
    anchor("bin 2", "2.start")
    anchor("out", "3.end")
    anchor("bout", "3.start")
  },
  "nand gate": {
    subcomponents.at("and gate body")
    circle("curve.right", radius: 0.1, anchor: "left", name: "circle")
    
    line((-0.5, -0.25), (rel: (-0.5, 0)), name: "1")
    line((-0.5, 0.25), (rel: (-0.5, 0)), name: "2")
    line("circle.right", (1, 0), name: "3")
    
    anchor("in 1", "1.end")
    anchor("bin 1", "1.start")
    anchor("in 2", "2.end")
    anchor("bin 2", "2.start")
    anchor("out", "3.end")
    anchor("bout", "3.start")
  }


)

#let node(component, position, name: none, anchor: none) = group(name: name, anchor: anchor, {
  assert(component in components, message: "Component '" + component + "' is unknown")
  import "../typst-canvas/draw.typ": anchor
  translate(position)
  components.at(component)
})