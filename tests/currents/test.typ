#set page(width: auto, height: auto, margin: 1cm)

#import "/src/lib.typ": cetz, components
#import cetz: *

#canvas({
  import components: *
  import draw: *
  resistor((2, 1), (0, 1), i: ("<", $i_1$))
  resistor((0, 0), (2, 0), i: ("<", $i_1$))

  for a in (
    "^>",
    "_>",
    "^<",
    "_<",
    ">^",
    ">_",
    "<^",
    "<_",
  ) {
    resistor(
      (rel: (-2, -1.5)),
      (rel: (2,0)),
      i: (a, $i_1$),
    )
  }
})
