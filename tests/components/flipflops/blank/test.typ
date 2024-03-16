#set page(width: auto, height: auto, margin: 1cm)
#import "/src/lib.typ": cetz, components, show-anchor
#import cetz: *

#canvas({
  import components: *
  import draw: *
  set-style(
    stroke: (thickness: 0.4pt)
  )

  flipflop((), name: "FF", l: "FF")
  for a in (
    "up",
    "down",
    "pin 1",
    "pin 2",
    "pin 3",
    "pin 4",
    "pin 5",
    "pin 6",
  ) {
    show-anchor("FF." + a)
    show-anchor("FF.b" + a)
  }
})
