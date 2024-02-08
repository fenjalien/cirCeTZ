#set page(width: auto, height: auto)

#import "/src/lib.typ": cetz, components
#import cetz: *

#canvas({
  import components: *
  import draw: *

  isource((0,0), (0,3))
  line((), (2,3))
  resistor((), (2, 0))
  line((), (0,0))
})
