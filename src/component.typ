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
  component-text: "center"

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

  assert(pos.len() in (1, 2), message: "Expected 1 or 2 positional arguments, got " + repr(pos.len()))

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

    let component-text = style.component-text

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
        scale(1.4 * style.at("scale", default: 1))
        
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
      draw-labels(component-name, l, a, i, v, f)
      draw-poles(poles)
    } else {
      if l != none {
        content("component.text", l, anchor: if component-text == "left"{ "west" } else { "center" }, padding: 0.1)
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
