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
      ("start", 50%, "end")
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
  content((rel: (0, -0.8em), to: "component.south"), input)
  content(
    (
      rel: (0, -0.4em),
      to: ("component.west", 50%, "start"), 
    ),
    $-$
  )
  content(
    (
      rel: (0, -0.4em),
      to: ("component.east", 50%, "end"), 
    ),
    $+$
  )
}

#let draw-labels(
  component-name,
  rotation,
  measure,
  label,
  annotation,
  current,
  voltage,
  flow
) = {
  if label != none {
    let (width, height) = measure(label)
    content(
      (
        rel: (0, 0.25em),
        to: (
          rel: (
            0,
            width/2 * calc.abs(calc.sin(rotation)) + height/2 * calc.abs(calc.cos(rotation))
          ),
          to: "component.north"
        )
      ),
      label
    )
  }
  if annotation != none {
    let (width, height) = measure(annotation)
    content(
      (
        rel: (0, -0.25em),
        to: (
          rel: (
            0,
            -width/2 * calc.abs(calc.sin(rotation)) - height/2 * calc.abs(calc.cos(rotation))
          ),
          to: "component.south"
        )
      ),
      annotation
    )
  }
  if current != none {
    draw-current(component-name, current)
  }
  if voltage != none {
    draw-voltage(voltage)
  }
  
}