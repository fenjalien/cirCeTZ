#set page(width: auto, height: auto, margin: 1cm)

#import "/src/lib.typ": cetz, components
#import cetz: *

#canvas({
  import components: *
  import draw: *
  set-style(
    stroke: (thickness: 0.4pt),
    circetz: (:)
  )

  let show-coord = true
  let coord(coord) = if show-coord {
    circle(coord, radius: 1pt, stroke: (paint: red))
    content((rel: (45deg, 0.1cm)), text(coord.split(".").last(), size: 5pt, fill: red), anchor: "south-west")
  }

  npn((0, 0), name: "Q")
  coord("Q.default")
  coord("Q.B")
  coord("Q.C")
  coord("Q.E")
})