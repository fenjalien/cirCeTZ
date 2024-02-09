#import "/src/dependencies.typ": cetz
#import "/src/labels.typ": draw-labels

#let draw-poles(poles) = {
  if type(poles) != str {
    return
  }
  assert(poles.len() in (2, 3))
  import "/src/components.typ": circ
  for (pos, pole) in (("start", poles.first()), ("end", poles.last())) {
    if pole == "*" {
      circ(pos)
    }
  }
}

#let component-default-style = (
  style: (
    current: "european",
    voltage: "european",
    port: "american",
    resistor: "american",
    inductor: "cute"
  ),
  stroke: (thickness: 0.4pt, join: "round"),
  thickness: 2,
  fill: auto,
  mark: none,
)


#let component(
  component-name,
  func,
  default-style,
  name: none,
  anchor: none,
  l: none,
  i: none,
  v: none,
  f: none,
  a: none,
  poles: none,
  mirror: false,
  invert: false,
  ..position-style,
  ) = {
  let user-anchor = anchor
  import cetz.draw: *

  let pos = position-style.pos()

  assert(pos.len() in (1, 2), message: "aaaa")

  group(name: name, ctx => {
    if pos.len() == 1 {
      set-origin(pos.first())
    } else {
      let (ctx, ..pos) = cetz.coordinate.resolve(ctx, ..pos)
      anchor("start", pos.first())
      anchor("end", pos.last())
      set-origin((pos.first(), 50%, pos.last()))
      rotate(cetz.vector.angle2(..pos))
    }

    let style = cetz.styles.resolve(
      ctx.style,
      root: "circetz",
      base: component-default-style
    )
    scale(1.4)

    group(
      name: "component",
      anchor: user-anchor,
      {
        if mirror or invert {
          scale(
            y: if mirror { -1 } else { 1 },
            x: if invert { -1 } else { 1 }
          )
        }
        let style = cetz.styles.resolve(
          style,
          root: component-name,
          merge: position-style.named(),
          base: default-style
        )

        set-style(..{
          (:)
          if "thickness" in style {
            (stroke: (thickness: style.stroke.thickness * style.thickness))
          }
        })

        func(style)
        
        if mirror or invert {
          scale(
            y: if mirror { -1 } else { 1 },
            x: if invert { -1 } else { 1 }
          )
        }
        if pos.len() == 2 {
          hide(rect("a", "b", name: "rect"))
          copy-anchors("rect")
        }
      }
    )

    if pos.len() == 2 {
      line("component.west", "start", stroke: style.stroke)
      line("component.east", "end", stroke: style.stroke)
      draw-labels(component-name, l, a, i, v, f)
      draw-poles(poles)
    }
    if name != none {
      copy-anchors("component")
    }
  })
  for p in pos {
    move-to(p)
  }
}
