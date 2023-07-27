#set page(width: auto, height: auto, margin: 0.5cm)
#import "@preview/cetz:0.0.1"

#cetz.canvas(length: 1cm, debug: false, {
  import cetz.draw: line, content
  import "../../circuitypst.typ": node, to

  to("isourceAM", (0,0), (0,3), label: $I_0$, v: h(0.5em) + $V_0$)
})
