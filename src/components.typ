#import "/src/component.typ": component

#let sources() = {

}

#let isource(..inputs) = component(
  "isource",
  (style) => {
    circle((0, 0), radius: 0.5)
    line((0, 0.5), (0, -0.5))
  },
  (
    stroke: auto,
    fill: auto,
  ),
  ..inputs
)