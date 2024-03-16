#import "/src/dependencies.typ": cetz
#import "/src/labels.typ": draw-labels

#let draw-poles(poles) = {
  if type(poles) != str {
    return
  }
  assert(poles.len() in (2, 3))
  import "/src/components/terminal-shapes.typ": circ, ocirc
  for (pos, pole) in (("start", poles.first()), ("end", poles.last())) {
    if pole == "*" {
      circ(pos)
    } else if pole == "o" {
      ocirc(pos)
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
  stroke: (thickness: 0.4pt),
  thickness: 2,
  fill: auto,
  mark: none,
  nodes-width: 0.04,
  scale: 1,
  component-text: "center",
  external-pins: (
    width: 0.2,
    thickness: 1
  )

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
  rotate: 0deg,
  ..position-style,
  ) = {
  let user-anchor = anchor
  let rotation = rotate
  import cetz.draw: *

  let pos = position-style.pos()
  assert(pos.len() in (1, 2), message: "Expected 1 or 2 positional arguments, got " + repr(pos.len()))
  let _ = pos.map(cetz.coordinate.resolve-system)

  assert(rotation == 0deg or pos.len() == 1, message: "Rotation is only supported for node placement.")
  let _ = if type(rotation) != angle {
    cetz.coordinate.resolve-system(rotation)
  }

  group(name: name, ctx => {
    let rotation = rotation
    if pos.len() == 1 {
      set-origin(pos.first())
      if type(rotation) != angle {
        let (_, pos, c) = cetz.coordinate.resolve(ctx, pos.first(), rotation)
        rotation = cetz.vector.angle2(pos, c)
      }
    } else {
      let (ctx, ..pos) = cetz.coordinate.resolve(ctx, ..pos)
      anchor("start", pos.first())
      anchor("end", pos.last())
      set-origin((pos.first(), 50%, pos.last()))
      rotation = cetz.vector.angle2(..pos)
    }
    rotate(rotation)

    let style = cetz.styles.resolve(
      ctx.style,
      root: "circetz",
      base: component-default-style
    )

    let component-text = style.component-text
    let label-size = cetz.util.measure(ctx, l)

    group(
      name: "component",
      anchor: user-anchor,
      {
        anchor("default", (0,0))
        if mirror or invert {
          scale(
            y: if mirror { -1 } else { 1 },
            x: if invert { -1 } else { 1 }
          )
        }
        style = if type(component-name) == str {
          cetz.styles.resolve(
            style,
            root: component-name,
            merge: position-style.named(),
            base: default-style
          )
        } else {
          // panic(cetz.styles.resolve(style, root: "transisto"))
          cetz.styles.resolve(
            cetz.styles.resolve(
              style,
              root: component-name.first(),
              base: default-style.first()
            ),
            root: component-name.last(),
            merge: cetz.util.merge-dictionary(style.at(component-name.first(), default: (:)), position-style.named()),
            base: default-style.join()
          )
        }
        scale(1.4 * style.at("scale", default: 1))

        style.label = label-size
        
        if "stroke" in style {
          style.stroke = cetz.util.resolve-stroke(style.stroke)
        }
        if "component-text" in style {
          component-text = style.component-text
        }

        func(style)
        
        if mirror or invert {
          scale(
            y: if mirror { -1 } else { 1 },
            x: if invert { -1 } else { 1 }
          )
        }
        if pos.len() == 2 and component-name != "short" {
          hide(rect("a", "b", name: "rect"))
          copy-anchors("rect")
        }
        ()
      }
    )

    if pos.len() == 2 {
      if component-name == "short" {
        line("start", "end", stroke: style.stroke)
      } else {
        line("component.west", "start", stroke: style.stroke)
        line("component.east", "end", stroke: style.stroke)
      }
      draw-labels(component-name, rotation, cetz.util.measure.with(ctx), l, a, i, v, f)
      draw-poles(poles)
    } else {
      if l != none {
        content(
          "component.text",
          l,
          anchor: if component-text == "left" { "west" } else { "center" },
          padding: 0
        )
      }
    }
    if name != none {
      copy-anchors("component")
    }
  })
  for p in pos {
    move-to(p)
  }
}
