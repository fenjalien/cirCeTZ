#set page(width: auto, height: auto, margin: 1cm)

#import "/src/lib.typ": cetz, components
#import cetz: *

#set text(0.8em)

#canvas({
  import components: *
  import draw: *
  set-style(
    stroke: (thickness: 0.4pt),
    circetz: (
      scale: 0.8,
      component-text: "left"
    )
  )

  let myNIA(label, pos, R1, R2) = group(name: label, {
    anchor("in", pos)
    short("in", (rel: (1, 0)))

    op-amp((), name: label, l: raw(label), anchor: "+", fill: color.rgb("00FFFF").lighten(20%))

    line(label + ".-", (rel: (0, -1)), name: "FB")

    resistor((), (rel: (0,-2)), l: R1)

    ground(())

    resistor("FB.end", ((), "-|", label + ".out"), poles: "*-", l: R2)
    line((), label + ".out")

    short(label + ".out", (rel: (1,0)), poles: "*-")
    anchor("out", ())
  })

  myNIA("OA1", (0,0), $R_1$, $R_2$)
  myNIA("OA2", "OA1.out", $R_3$, $R_4$)

  ocirc("OA1.in")
  content((), $ v_i $, anchor: "south", padding: 0.1)
  ocirc("OA2.out")
  content((), $ v_o $, anchor: "south", padding: 0.1)
})