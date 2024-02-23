#set page(width: auto, height: auto, margin: 1cm)
#import "/src/lib.typ": cetz, components
#import cetz: *

#canvas({
  import components: *
  import draw: *
  set-style(
    stroke: (thickness: 0.4pt)
  )

  for dir in range(-135, 181, step: 45) {
    resistor((0,0), (dir * 1deg, 2.5), l: [#dir])
  }
})
