#import "/src/component.typ": component
#import "/src/dependencies.typ": cetz

#import cetz.draw: *

#import "/src/components/arrows.typ": currarrow

#let isource(..inputs) = component(
  "isource",
  (style) => {
    style.stroke.thickness *= style.thickness
    circle(
      (0, 0),
      radius: (style.width/2, style.height/2),
      name: "c",
      stroke: style.stroke,
      fill: style.fill
    )
    anchor("a", ("c.west", "|-", "c.south"))
    anchor("b", ("c.east", "|-", "c.north"))
    if style.style.current == "european" {
      line("c.south", "c.north", stroke: style.stroke)
    } else if style.style.current == "american" {
      line(
        ("c.west", 30%, "c.center"),
        ("c.east", 30%, "c.center"),
        stroke: style.stroke
      )
      currarrow(("c.east", 50%, "c.center"))
    }
  },
  (
    stroke: auto,
    thickness: auto,
    fill: auto,
    style: auto,
    scale: auto,
    width: 0.6,
    height: 0.6
  ),
  ..inputs
)