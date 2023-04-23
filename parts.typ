#import "../typst-canvas/draw.typ": *

#let and-gate-body = {
  arc("center", 0deg, 180deg, radius: 0.5, name: "curve", anchor: "origin")
  line(
    "curve.start",
    (rel: (-0.5, 0)), 
    (rel: (0, -1)),
    (rel: (0.5, 0))
  )
  anchor("bin 1", (rel: (-0.5, 0.75)))
  anchor("in 1", (rel: (-0.5, 0)))
  anchor("in 2", (rel: (0, -0.5)))
  anchor("bin 2", (rel: (0.5, 0)))
  anchor("bout", (rel: (1, 0.25)))
  anchor("out", (rel: (0.5, 0)))
}

#let or-gate-body = {
  arc((rel: (0.5, 0)), 0deg, 60deg, anchor: "end", name: "tcurve")
  arc((), 120deg, 180deg, name: "bcurve")
  move-to("center")
  line((rel: (-0.5, 0.5)), "tcurve.start")
  move-to("center")
  line((rel: (-0.5, -0.5)), "bcurve.end")
  move-to("center")
  arc((rel: (-0.5, 0.5)), 60deg, 120deg)

  
  // x coordinate of where the input legs touch the body of the gate
  let x = calc.cos(calc.asin(0.25)) - calc.cos(calc.asin(0.5))
  anchor("bin 1", (rel: (x, -0.25)))
  anchor("bin 2", (rel: (0, -0.5)))
  anchor("in 2", (rel: (-0.5-x, 0)))
  anchor("in 1", (rel: (0, 0.5)))
  anchor("bout", (rel: (1.5, -0.25)))
  anchor("out", (rel: (0.5, 0)))
}

#let logic-gate-legs = for a in ("in 1", "in 2", "out") {
  line("b" + a, a)
}