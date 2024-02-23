#import "/src/dependencies.typ": cetz
#import "/src/components.typ"


#let show-coord(coord) = {
  import cetz.draw: *
  circle(coord, radius: 1pt, stroke: (paint: red), name: "pin")
  content((rel: (45deg, 0.1cm)), text(coord.split(".").last(), size: 5pt, fill: red), anchor: "south-west", name: "label", frame: "rect", stroke: none, padding: 0.02)
  line("pin", "label", stroke: (paint: red))
}
/*
#let and-gate-style = (fill: auto, stroke: auto)

#let and-gate(..inputs) = {
  component(
    func: (style) => {
      import cetz.draw: *
      merge-path(close: true, {
        line(
          (0, 0.5),
          (-0.5, 0.5),
          (-0.5, -0.5)
        )
        arc((0,0), start: -90deg, stop: 90deg, radius: 0.5, anchor: "origin")
      })

      line((0.5, 0), (1, 0))
      line((-0.5, 0.25), (rel: (-0.5, 0)))
      line((-0.5, -0.25), (rel: (-0.5, 0)))
      utils.anchors((
        "in 1": (-1, 0.25),
        "in 2": (-1, -0.25),
        "out": (1, 0)
      ))
    },
    default-style: and-gate-style,
    ..inputs,
  )
}