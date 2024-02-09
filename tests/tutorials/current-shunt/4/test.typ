#set page(width: auto, height: auto, margin: 1cm)

#import "/src/lib.typ": cetz, components
#import cetz: *

#canvas({
  import components: *
  import draw: *
  set-style(
    stroke: (thickness: 0.4pt),
    circetz: (
      style: (current: "american"),
    )
  )
  isource((0,0), (0,3), l: $I_0$, mirror: true)
  short((), (2,3), i: $I_0$, poles: "-*")
  resistor(
    (), (2, 0),
    l: $R_1$,
    i: (">_", $i_1$),
    poles: "-*",
  )
  line((), (0,0))
  line((2, 3), (4, 3))
  resistor(
    (),(4, 0),
    l: $R_2$,
    i: (">_", $i_2$)
  )
  line((), (2, 0))
})
