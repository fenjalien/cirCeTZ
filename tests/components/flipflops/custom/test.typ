#set page(width: auto, height: auto, margin: 1cm)
#import "/src/lib.typ": cetz, components
#import cetz: *

#canvas({
  import components: *
  import draw: *
  set-style(
    stroke: (thickness: 0.4pt)
  )

  flipflop(
    (),
    name: "FF",
    t: (
      "1": [A],
      "2": `CLK`,
      "3": [B],
      "6": [Q],
      "4": overline[Q],
      d: [rst]
    ),
    c: ("2",),
    n: ("d", "2")
  )
})
