#set page(width: auto, height: auto, margin: 0.5cm)
#import "@preview/cetz:0.0.1"

#cetz.canvas({
  import cetz.draw: line, content
  import "../../circuitypst.typ": node, to

  node("nand gate", (0,1), name: "g1")
  content("g1.out", [#h(0.5em) Q], anchor: "left")
  line("g1.in 1", (rel: (0, 0.5)), name: "l1")
  line("g1.in 2", (rel: (0, -0.5)), name: "l2")
  node("nand gate", "l1.end", anchor: "out", name: "g2")
  node("nand gate", "l2.end", anchor: "out", name: "g3")
  line("g2.in 2", "g3.in 1", name: "l3")
  node("nand gate", "l3.center", anchor: "out", name: "g4")
  line("g4.in 1", (rel: (0, 0.75)), name: "l4")
  line("g4.in 2", (rel: (0, -0.75)), name: "l5")
  line("g2.in 1", "l4.end")
  line("g3.in 2", "l5.end")
  line("l4.end", (rel: (-0.5, 0)), name: "l6")
  line("l5.end", (rel: (-0.5, 0)), name: "l7")
  content("l6.end", [A #h(0.5em)], anchor: "right")
  content("l7.end", [B #h(0.5em)], anchor: "right")
  
  node("circ", "g4.out")
  node("circ", "l4.end")
  node("circ", "l5.end")
})
