#set page(width: auto, height: auto, margin: 1cm)
#import "/src/lib.typ": cetz, components, show-anchor
#import cetz: *

#canvas({
  import components: *
  import draw: *
  set-style(
    stroke: (thickness: 0.4pt),
    circetz: (
      logic-ports: (
        scale: 2
      )
    )
  )

  let sr-ff = flipflop.with(
    t: (
      "1": [S],
      "2": [CP],
      "3": [R],
      "4": overline[Q],
      "6": [Q]
    ),
    n: ("d",)
  )

  // sr-ff(())
  // and-port(())
  line((0,0), (1,0))
  arc((), start: 90deg, stop: 0deg)
  line((), (rel: (0, -1)))
  arc((), start: 180deg, stop: 270deg)
  line((), (rel: (1, 0)))
})
