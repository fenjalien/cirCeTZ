#import "/src/dependencies.typ": cetz
#import cetz: vector
#import cetz.draw: anchor

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