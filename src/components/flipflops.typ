#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

#import cetz.draw: *

#let flipflop-class(
  name,
  style,
  ..inputs
) = component(
  ("flipflops", name),
  style => {
    let numpins = 6
    // Halved
    let height = numpins * style.pin-spacing/4
    let width = style.width/2
    let wedge = style.pin-spacing * style.clock-wedge-size

    anchor("text", (0,0))

    rect(
      (-width, -height),
      (width, height),
      stroke: (thickness: style.stroke.thickness * style.thickness)
    )

    anchor("bpin 1", (-width, style.pin-spacing))
    anchor("pin 1", (rel: (-style.external-pins.width, 0)))
  
    anchor("bpin 2", (-width, 0))
    anchor("pin 2", (rel: (-style.external-pins.width, 0)))
  
    anchor("bpin 3", (-width, -style.pin-spacing))
    anchor("pin 3", (rel: (-style.external-pins.width, 0)))
  
    anchor("bpin 4", (width, -style.pin-spacing))
    anchor("pin 4", (rel: (style.external-pins.width, 0)))
  
    anchor("bpin 5", (width, 0))
    anchor("pin 5", (rel: (style.external-pins.width, 0)))
  
    anchor("bpin 6", (width, style.pin-spacing))
    anchor("pin 6", (rel: (style.external-pins.width, 0)))
  
    anchor("bup", (0, height))
    anchor("up", (rel: (0, style.external-pins.width)))
  
    anchor("bdown", (0, -height))
    anchor("down", (rel: (0, -style.external-pins.width)))

    let t = inputs.named().at("t", default: (:))
    let c = inputs.named().at("c", default: ())
    let n = inputs.named().at("n", default: ())

    for k in (t.keys() + c + n).dedup() {
      assert(k in ("1", "2", "3", "4", "5", "6", "u", "d"))
      let pos = "bpin " + k
      let size = style.font-size
      let anchor = "east"
      let rot = 90deg
      if k in ("u", "d") {
        size = style.font-size-ud
        if k == "u" { 
          pos = "bup"
          anchor = "north"
          rot = 0deg
        } else {
          pos = "bdown"
          anchor = "south"
          rot = 180deg
        }
      } else if k in ("1", "2", "3") {
        anchor = "west"
        rot = -90deg
      }
      
      line(pos, pos.slice(1))
      
      if k in t {
        content(
          pos,
          {
            set text(size: size)
            t.at(k)
          },
          anchor: anchor,
          padding: style.padding + if k in c { wedge }
        )
      }
      if k in c {
        group({
          set-origin(pos)
          rotate(rot)
          line((wedge, 0), (0, wedge), (-wedge, 0))
        })
      }
      if k in n {
        import "logic-ports.typ": notcirc
        notcirc(
          pos,
          scale: 1/1.4,
          anchor: (
            north: "south",
            south: "north",
            west: "east",
            east: "west"
          ).at(anchor)
        )
      }
    }

  },
  (
    (
      external-pins: auto,
      thickness: auto,
      scale: auto,
      stroke: auto,
      width: 1.2,
      pin-spacing: 0.6,
      clock-wedge-size: 0.2,
      font-size: 9pt,
      font-size-ud: 5pt,
      padding: 0.1
    ),
    style
  ),
  ..inputs
)

#let flipflop = flipflop-class.with("flipflop", (scale: auto))

#let latch = flipflop-class.with(
  "latch",
  (scale: auto),
  t: (
    "1": [D],
    "3": [CLK],
    "4": overline[Q],
    "6": [Q]
  )
)