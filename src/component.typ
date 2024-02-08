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
}

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
        let style = cetz.styles.resolve(
          ctx.style,
          root: component-name,
          merge: position-style.named(),
          base: default-style
        )
        func(style)
        hide(rect("a", "b", name: "rect"))
        copy-anchors("rect")
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
