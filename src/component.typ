#import "/src/dependencies.typ": cetz


#let labels(
  label,
  annotation,
  current,
  voltage,
  flow
) = {
  import cetz.draw: *
  if label != none {
    content((rel: (0, 0.8em), to: "component.north"), label)
  }
  if annotation != none {
    content((rel: (0, -0.8em), to: "component.south"), annotation)
  }
  if current != none {
    import "/src/components.typ": currarrow
    currarrow(("component.east", 50%, "end"))
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

    group(
      name: "component",
      anchor: user-anchor,
      {
        // panic(cetz.styles.resolve(ctx.style, base: component-default-style, root: ""))
        func(
          cetz.styles.resolve(
            cetz.styles.resolve(
              ctx.style,
              root: "circetz",
              base: component-default-style
            ),
            root: component-name,
            merge: position-style.named(),
            base: default-style
          )
        )
        if pos.len() == 2 {
          hide(rect("a", "b", name: "rect"))
          copy-anchors("rect")
        }
      }
    )

    if pos.len() == 2 {
      line("component.west", "start")
      line("component.east", "end")
      labels(l, a, i, v, f)
    }
    if name != none {
      copy-anchors("component")
    }
  })
  move-to(pos.last())
}
