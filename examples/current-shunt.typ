#import "@preview/cetz:0.0.1"

#lorem(30)

#figure(
  cetz.canvas(length: 1cm, debug: false, {
    import cetz.draw: line
    import "@local/circuitypst:0.0.1": node, to

    to("isourceAM", (0,0), (0,3), label: $I_0$, v: h(0.5em) + $V_0$)
    to("short", (), (2,3), i: $I_0$,)
    to("R", (), (2, 0), label: [$R_1$], poles: "*-*", i: (">_", $i_1$))
    line((2,3), (4,3))
    to("R", (), (4, 0), label: [$R_2$], name: "R", i: (">_", $i_2$))
    line((), (0,0))
  }),
  caption: [Current Shunt]
)

#lorem(30)

