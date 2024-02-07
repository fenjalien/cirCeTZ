#import "/src/dependencies.typ": cetz

#let component(
  func,
  default-style,
  component-name,
  name: none,
  anchor: none,
  ..position-style,
  ) = {
  let user-anchor = anchor
  import cetz.draw: *

  let pos = position-style.pos()

  assert(pos.len() in (1, 2), message: "aaaa")

  group(
    name: name,
    anchor: user-anchor,
    ctx => {
      set-origin(position)
      
      func(
        cetz.styles.resolve(
          ctx.style,
          root: component-name,
          merge: style.named(),
          base: default-style
        )
      )
    },
  )
  move-to(position)
}
