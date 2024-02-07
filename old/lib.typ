#import "components.typ"
#import "utils.typ"

#import "@preview/cetz:0.1.0"

#import cetz.draw: *
#import cetz.coordinate
#import cetz.vector

#let canvas-fill = fill
#let canvas-stroke = stroke

// #let draw-component(component) = {
//   ((
//     children: components.
//   ),)
// }

#let node(component, position, label: none, name: none, anchor: none, fill: auto, stroke: auto, ..options) = {
  assert(component in components.node, message: "Component '" + component + "' is unknown")
  group(name: name, anchor: anchor, {
    import cetz.draw: anchor

    if fill != auto {
      canvas-fill(fill)
    }
    if stroke != auto {
      canvas-stroke(stroke)
    }

    set-origin(position)
    anchor("center", (0,0))
    components.node.at(component)
    utils.anchors((
      // IM A GENIUS
      "north east": ("north", "-|", "east"),
      "south east": ("south", "-|", "east"),
      "north west": ("north", "-|", "west"),
      "south west": ("south", "-|", "west"),
      n: "north",
      s: "south",
      e: "east",
      w: "west",
    ))
    if label != none {
      content("center", label)
    }
  })
  move-to(position)
}

#let to(
  component, 
  start, 
  end, 
  label: none, 
  name: none, 
  i: none,
  v: none,
  poles: none,
  stroke: auto,
  fill: auto,
  ) = {
  assert(component in components.path, message: "Component '" + component + "' is unknown")
  group(name: name, {
    if fill != auto {
      canvas-fill(fill)
    }
    if stroke != auto {
      canvas-stroke(stroke)
    }
    anchor("start", start)
    anchor("end", end)
    

    // This transformation moves (0,0) to the mid point of the line and rotates such that the line from -> to lies flat on the x axis
    rotate((
        utils.get-angle,
        // (s, e) => panic(utils.get-angle(s, e)),
        "start",
        "end"
      ))
    // rotate(90deg)
    set-origin(("start", 0.5, "end"))

    anchor("center", (0,0))

    line("start", (-0.5, 0))
    line("end", (0.5, 0))
    components.path.at(component)
    utils.anchors((
      west: (-0.5, 0),
      east: (0.5, 0),
      // IM A GENIUS
      "north east": ("north", "-|", "east"),
      "south east": ("south", "-|", "east"),
      "north west": ("north", "-|", "west"),
      "south west": ("south", "-|", "west"),
      n: "north",
      s: "south",
      e: "east",
      w: "west",
    ))

    if label != none {
      content("label", label)
    }

    if v != none {
      assert(type(v) == "content" or (type(v) == "array" and i.len() == 2 and type(v.first()) == "string" and type(v.last()) == "content"), message: "Invalid voltage syntax")

      let y = -0.3
      let plus = ((v1, v2) => vector.add(vector.lerp(v1, v2, 0.25), (0, y, 0)), "east", "end")
      let minus = ((v1, v2) => vector.add(vector.lerp(v1, v2, 0.75), (0, y, 0)), "start", "west")

      content((rel: (0,y), to: ("east", 0.25, "end")), $+$)
      content((rel: (0,y), to: ("start", 0.75, "west")), $-$)
      content("annotation", v)
    }

    if i != none {
      assert(type(i) == "content" or (type(i) == "array" and i.len() == 2 and type(i.first()) == "string" and type(i.last()) == "content"), message: "Invalid current label syntax")

      let from = "east"
      let to = "end"
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
          from = "west"
          to = "start"
        }
        if lr == "<" {
          d = 180deg
          y *= -1
        }
      } else if component == "short" {
        from = "west"
        to = "east"
      }

      rotate(d)
      node("currarrow", (from, 0.5, to))
      content((rel: (0, y)), c)
      rotate(-d)
    }

    if poles != none {
      if type(poles) == "string" {
        poles = (poles.first(), poles.last()).map(p => ("*": "circ", d: "diamondpole", s: "squarepole", o: "ocirc").at(p, default: none))
      }
      assert(type(poles) == "array" and poles.len() == 2)
      if poles.first() != none {
        node(poles.first(), "start")
      }
      if poles.last() != none {
        node(poles.last(), "end")
      }
    }
  })
  move-to(end)
}
