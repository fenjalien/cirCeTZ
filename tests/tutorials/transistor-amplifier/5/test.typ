#set page(width: auto, height: auto, margin: 1cm)
#import "/src/lib.typ": cetz, components, show-coord
#import cetz: *
#import "@preview/metro:0.2.0": qty

#canvas({
  import components: *
  import draw: *
  set-style(
    stroke: (thickness: 0.4pt),
    circetz: (
      scale: 1,
      transistor: (arrow-pos: "end"),
    ),
    content: (
      padding: 0.1,
      stroke: none
    ),
  )


  nmos((0,0), l: [Q1], name: "Q1", mos-arrows: true)

  resistor("Q1.S", (rel: (0, -3)), l: [$R_S$ \ #qty(5, "kohm")])
  vee((), l: $ V_(E E) = qty(-10, V) $, name: "VEE")

  resistor("Q1.D", (rel: (0, 3)), a: [$R_D$ \ #qty(10, "kohm")])
  vcc((), l: $ V_(C C) = qty(10, V) $, name: "VCC")

  short("Q1.S", (rel: (2, 0)))
  capacitor((), (rel: (0, -1.5)), l: $C_1$)
  ground((), name: "GND")

  short("Q1.G", (rel: (-1, 0)))
  circle((), name: "in", radius: 0)
  resistor((), ((), "|-", "GND"), l: [$R_G$ \ #qty(1, "Mohm")])
  ground(())

  capacitor("in", (rel: (-1.5, 0)), a: $C_2$, poles: "*-o")
  content((), $v_i = v_(i 1)$, anchor: "east")

  short("Q1.D", (rel: (1, 0)), poles: "-o")
  content((), $v_(o 1)$, anchor: "west", name: "vo1", frame: "rect")
  
  npn((rel: (2,0), to: "vo1"), anchor: "B", name: "Q2", l: [Q2])

  short("Q2.B", (rel: (-0.5, 0)), poles: "-o")
  content((), $v_(12)$, anchor: "east", name: "v12", frame: "rect")

  resistor("Q2.E", ((), "|-", "VEE"), l: [$R_E$ \ #qty(9.3, "kohm")])
  vee(())

  short("Q2.E", (rel: (1, 0)), poles: "-o")
  content((), $v_(o 2)$, name: "vo2", anchor: "west", frame: "rect")

  short("Q2.C", ((), "|-", "VCC"))
  vcc(())

  line("vo2", (rel: (1.5, 0)), stroke: (dash: "densely-dashed"))
  capacitor((), (rel: (1,0)), l: $C_3$)
  resistor((), ((), "|-", "GND"), l: $R_L$)
  ground(())

  line("vo1", "v12", stroke: (dash: "densely-dashed"))

})