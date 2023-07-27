#set page(width: auto, height: auto, margin: 0.5cm)
#import "@preview/cetz:0.0.1"

#cetz.canvas(length: 1cm, debug: false, {
  import cetz.draw: line, content
  import "../../circuitypst.typ": node, to

  node("and gate", (0,0), name: "g1") 
  content("g1.out", h(0.5em)+[Carry], anchor: "left")
  node("xor gate", (0,-1.5), name: "g2")
  content("g2.out", h(0.5em)+[Sum], anchor: "left")

  line("g2.in 1", (rel: (-1, 0)), name: "l1")
  line("g1.in 1", (rel: (-1, 0)), "l1.end", (rel: (-1, 0)))
  content((), [B]+h(0.5em), anchor: "right")
  line("g1.in 2", (rel: (-0.5, 0)), name: "l2")
  line("g2.in 2", (rel: (-0.5, 0)), "l2.end", (rel: (-1.5, 0)))
  content((), [A]+h(0.5em), anchor: "right")

  node("circ", "l1.end")
  node("circ", "l2.end")
})
