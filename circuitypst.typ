#import "../typst-canvas/canvas.typ": canvas
#import "../typst-canvas/cmd.typ"
#import "../typst-canvas/vector.typ"

#let and-gate(position, name: none, anchor: none) = {
  ((
    name: name,
    default-anchor: "center",
    anchor: anchor,
    coordinates: (position,),
    custom-anchors: (position) => {
      (
        "in 1": (-1, -0.25),
        "bin 1": (-0.5, -0.25),
        "in 2": (-1, 0.25),
        "bin 2": (-0.5, 0.25),
        out: (1, 0),
        bout: (0.5, 0)
      ).pairs().map((value) => (value.first(), vector.add(value.last(), position))).fold((:), (anchors, item) => {anchors.insert(item.first(), item.last()); anchors})
    },
    render: (ctx, position) => {
      let offset = vec => vector.add(vec, position)
      // curved part
      cmd.arc(ctx, 0 + position.first(), 0.5 + position.last(), 0deg, 180deg, 0.5)
      
      // square part
      cmd.path(ctx, 
        ..((0, -0.5),
        (-0.5, -0.5),
        (-0.5, 0.5),
        (0, 0.5)).map(offset)
      )

      // input 1
      cmd.path(ctx,
        ..((-0.5, -0.25),
        (-1, -0.25),).map(offset)
      )

      // input 2
      cmd.path(ctx,
        ..((-0.5, 0.25),
        (-1, 0.25),).map(offset)
      )

      // output
      cmd.path(ctx,
        ..((0.5, 0),
        (1, 0),).map(offset)
      )
    }
  ),)
}

#canvas({
  import "../typst-canvas/draw.typ": *
  and-gate((1,0), name: "and")
  and-gate("and.out", anchor: "in 1")
})

#lorem(30)
