#import "../typst-canvas/vector.typ"

#let dist(v1, v2) = {
  return calc.abs(
    vector.len(
      vector.sub(
        v2,
        v1
      )
    )
  )
}