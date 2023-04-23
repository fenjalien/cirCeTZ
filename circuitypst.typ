#import "components.typ"

#import "../typst-canvas/draw.typ": *

#let node(component, position, name: none, anchor: none) ={
  group(name: name, anchor: anchor, {
    assert(component in components.node, message: "Component '" + component + "' is unknown")
    import "../typst-canvas/draw.typ": anchor
    // translate(position)
    anchor("center", position)
    components.node.at(component)
  })
  move-to(position)
}

#let to(
  component, 
  from, 
  to, 
  label: none, 
  name: none, 
  i: none,
  v: none,
  poles: none,
  ) = {
  group(name: name, {
    assert(component in components.path, message: "Component '" + component + "' is unknown")

    stroke(none)
    line(from, to, name: "outer")

    translate("outer.start")
    rotate(
      (
        (v1, v2) => if v2.at(1) < 0 {1} else {-1} * vector.angle(vector.sub(v2, v1), (0,0,0), (1,0,0)),
        "outer.start",
        "outer.end"
      )
    )

    line(
      (
        (v1, v2) => {
          let d = vector.dist(v1, v2)
          vector.lerp(v1, v2, (d - 1.4) / (2 * d))
        },
        "outer.start",
        "outer.end",
      ),
      (rel: (1.4, 0)),
      name: "inner"
    )

    stroke(black)
    line("outer.start", "inner.start")
    line("inner.end", "outer.end")
    components.path.at(component)

    if label != none {
      content("label", label)
    }

    if v != none {
      assert(type(v) == "content" or (type(v) == "array" and i.len() == 2 and type(v.first()) == "string" and type(v.last()) == "content"), message: "Invalid voltage syntax")

      let y = -0.3
      let plus = ((v1, v2) => vector.add(vector.lerp(v1, v2, 0.25), (0, y, 0)), "inner.end", "outer.end")
      let minus = ((v1, v2) => vector.add(vector.lerp(v1, v2, 0.75), (0, y, 0)), "outer.start", "inner.start")

      content(plus, $+$)
      content(minus, $-$)
      content("annotation", v)
      
    }

    if i != none {
      assert(type(i) == "content" or (type(i) == "array" and i.len() == 2 and type(i.first()) == "string" and type(i.last()) == "content"), message: "Invalid current label syntax")

      let from = "inner.end"
      let to = "outer.end"
      let c = i
      let y = 0.3
      let d = 0deg

      if type(i) == "array" {
        let p = i.first()
        c = i.last()

        let ab = p.find(regex("\^|_"))
        assert(ab != none, message: "'^' or '_' not found in `i`")
        if  ab == "_"{
          y *= -1
        }

        let lr = p.find(regex("<|>"))
        assert(lr != none, message: "'<' or '>' not found in `i`")
        if p.position(lr) == 0 {
          to= "outer.start"
          from = "inner.start"
        }
        if lr == "<" {
          d = 180deg
          y *= -1
        }
      } else if component == "short" {
        from = "inner.start"
        to = "inner.end"
      }

      rotate(d)
      node("currarrow", ((v1, v2) => vector.lerp(v1, v2, 0.5), from, to))
      content((rel: (0, y)), c)
      rotate(-d)
    }

    if poles != none {
      if type(poles) == "string" {
        poles = (poles.first(), poles.last()).map(p => if p == "*" {"circ"} else if p == "d" {"diamondpole"} else if p == "s" {"squarepole"} else {none})
      }
      assert(type(poles) == "array" and poles.len() == 2)
      if poles.first() != none {
        node(poles.first(), "outer.start")
      }
      if poles.last() != none {
        node(poles.last(), "outer.end")
      }
    }
  })
  move-to(to)
}
