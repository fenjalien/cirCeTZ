#set page(width: auto, height: auto, margin: 1cm)

#import "/src/lib.typ": cetz, components
#import cetz: *

#set text(0.8em)

#canvas({
  import components: *
  import draw: *
  set-style(
    stroke: (thickness: 0.4pt)
  )

  content((0,0), $ v_i $, anchor: "south", padding: 0.1)
  short((), (1, 0), poles: "o-", name: "s")
  op-amp((), name: "a", l: `OA1`, anchor: "+")
})