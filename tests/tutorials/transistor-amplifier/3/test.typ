#set page(width: auto, height: auto, margin: 1cm)
#import "/src/lib.typ": cetz, components, show-anchor
#import cetz: *
#import "@preview/metro:0.2.0": qty

#canvas({
  import components: *
  import draw: *
  set-style(
    stroke: (thickness: 0.4pt),
    circetz: (scale: 0.8)
  )

  nmos((0,0), l: [Q1], name: "Q1", mos-arrows: true, arrow-pos: "end")

  resistor("Q1.S", (rel: (0, -3)), l: [$R_S$ \ #qty(5, "kohm")])
  vee((), l: $ V_(E E) = qty(-10, V) $, name: "VEE")

  resistor("Q1.D", (rel: (0, 3)), a: [$R_D$ \ #qty(10, "kohm")])
  vcc((), l: $ V_(C C) = qty(10, V) $, name: "VCC")

  short("Q1.S", (rel: (2, 0)))
  capacitor((), (rel: (0, -1.5)), l: $C_1$)
  ground((), name: "GND")
  show-anchor("GND")
  show-anchor("VEE")
  show-anchor("VCC")
})