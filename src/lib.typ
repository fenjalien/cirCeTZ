#import "/src/dependencies.typ": cetz
#import "/src/components.typ"


#let show-anchor(anchor_, offset: "south-west", pos: (45deg, 0.1)) = {
  import cetz.draw: *
  circle(anchor_, radius: 1pt, stroke: (paint: red), name: "pin")
  content(
    (rel: pos),
    text(anchor_.split(".").last(), size: 5pt, fill: red),
    anchor: offset,
    name: "label",
    frame: "rect",
    stroke: none,
    padding: 0.02
  )
  line("pin", "label", stroke: (paint: red))
}
