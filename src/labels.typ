#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let draw-current(component-name, input) = {
  import "/src/components.typ": currarrow
  let (ab, lr, p) = if type(input) == array {
    let p = input.first()
    input = input.last()
    (p.find(regex("\^|_")), p.find(regex("<|>")), p.position(regex("<|>")))
  } else {
    (none, none, 1)
  }
  currarrow(
    if component-name == "short" {
      ("component.west", 50%, "component.east")
    } else if p == 0 {
      ("component.west", 50%, "start")
    } else {
      ("component.east", 50%, "end")
    },
    invert: lr == "<"
  )
  content(
    (rel: (0, 0.8em * if ab == "_" { -1 } else { 1 })),
    input
  )
}

#let draw-voltage(input) = {
  
}

#let draw-labels(
  component-name,
  label,
  annotation,
  current,
  voltage,
  flow
) = {
  if label != none {
    content((rel: (0, 0.8em), to: "component.north"), label)
  }
  if annotation != none {
    content((rel: (0, -0.8em), to: "component.south"), annotation)
  }
  if current != none {
    draw-current(component-name, current)
  }
  if voltage != none {
    draw-voltage(voltage)
  }
  
}