#import "@preview/cetz:0.0.1"
#import cetz.draw: anchor, vector


#let vector-dist(v1, v2) = {
  return calc.abs(
    vector.len(
      vector.sub(
        v2,
        v1
      )
    )
  )
}

#let get-angle(v1, v2, debug: false) = {
  // panic(v1, v2)

  let (x,y,z) = vector.sub(v2, v1)

  return calc.atan2(x,-y)
  
  // return -panic(if v2.at(1) < v1.at(1) {-1} else {1} * vector.angle(vector.sub(v2, v1), (0,0,0), (1,0,0)))
  // return -if v2.at(1) < v1.at(1) {-1} else {1} * vector.angle(vector.sub(v2, v1), (0,0,0), (1,0,0))
}

#let vector-rotate(v, angle) = {
  let (x, y, z) = v
  // panic(angle)
  (
    x * calc.cos(angle) - y * calc.sin(angle),
    x * calc.sin(angle) + y * calc.cos(angle),
    z
  )
}

#let defer-rotation(v, v1, v2) = {
  (
    (v, v1, v2) => {
      // panic(v)
  // panic(v1, v2)
      vector-rotate(v, -get-angle(v1, v2))
    },
    v,
    v1,
    v2
  )
}

// #let reverse-transform(v) = {
//   (
//     (start, center, v) => 
//   )
// }

#let anchors(anchors) = {
  for (k, v) in anchors {
    anchor(k, v)
  }
}
