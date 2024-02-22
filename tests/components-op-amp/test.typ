#set page(width: auto, height: auto, margin: 0.5cm)
#import "@preview/cetz:0.0.1"

#cetz.canvas(length: 1cm, debug: false, {
  import cetz.draw: line, content
  import "../../circuitypst.typ": node, to

  node("op amp", (0,-1.5), name: "g2")
})
