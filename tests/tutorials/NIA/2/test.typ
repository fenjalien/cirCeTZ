#set page(width: auto, height: auto, margin: 1cm)

#import "/src/lib.typ": cetz, components
#import cetz: *

#set text(0.8em)

#canvas({
  import components: *
  import draw: *
  set-style(
    stroke: (thickness: 0.4pt),
    circetz: (scale: 0.8)
  )

  content((0,0), $ v_i $, anchor: "south", padding: 0.1)
  short((), (1, 0), poles: "o-", name: "s")

  op-amp((), name: "OA", l: `OA1`, anchor: "+")

  line("OA.-", (rel: (0, -1)))

  resistor((), (rel: (0,-2)), l: $R_1$)

  ground(())
})