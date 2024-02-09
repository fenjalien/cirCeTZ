#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

#import cetz.draw: *

#import "/src/components/arrows.typ": currarrow

#let isource(..inputs) = component(
  "isource",
  (style) => {
    circle(
      (0, 0),
      radius: (style.width/2, style.height/2),
      name: "c"
    )
    anchor("a", ("c.west", "|-", "c.south"))
    anchor("b", ("c.east", "|-", "c.north"))
    if style.style.current == "european" {
      line("c.south", "c.north")
    } else if style.style.current == "american" {
      line(
        ("c.west", 30%, "c.center"),
        ("c.east", 30%, "c.center"),
      )
      currarrow(("c.east", 50%, "c.center"))
    }
  },
  (
    stroke: auto,
    thickness: auto,
    fill: auto,
    style: (auto),
    width: 0.6,
    height: 0.6
  ),
  ..inputs
)