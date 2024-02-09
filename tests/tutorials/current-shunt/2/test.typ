#set page(width: auto, height: auto)

#import "/src/lib.typ": cetz, components
#import cetz: *

#canvas({
  import components: *
  import draw: *
  set-style(
    circetz: (style: (current: "american"))
  )
  isource((0,0), (0,3), l: $I_0$)
  line((), (2,3))
  resistor((), (2, 0), l: $R_1$)
  line((), (0,0))
  line((2, 3), (4, 3))
  resistor((), (4, 0), l: $R_2$)
  line((), (2, 0))
})
