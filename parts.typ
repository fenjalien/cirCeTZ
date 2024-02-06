#import "../typst-canvas/draw.typ": *
#import "utils.typ": anchors

#let add-gate-body = {
  line(
    (-0.5, 0.8),
    (-0.5, 0.3),
    (-0.2, 0),
    (-0.5, -0.3),
    (-0.5, -0.8),
    (0.5, -0.6),
    (0.5, 0.6),
    (-0.5, 0.8)
  )
  line(
    (0, 0),
    (0.3, 0)
  )
  line(
    (0.15, 0.15),
    (0.15, -0.15)
  )
  anchors((
    "bin 1": (-0.5, 0.55),
    "in 1": (rel: (-0.5, 0)),
    "bin 2": (-0.5, -0.55),
    "in 2": (rel: (-0.5, 0)),
    "bcin": (0, -0.7),
    "cin": (rel: (0, -0.3)),
    "bcout": (0, 0.7),
    "cout": (rel: (0, 0.3)),
    "bout": (0.5, 0),
    "out": (rel: (0.5, 0)),
    "north": (0, 1),
    "south": (rel: (0, -1)),
    "east": "out",
    "west": ("in 1", "|-", "center"),
    "left": ("bin 1", "|-", "center"),
    "right": "bout"
  ))
}

#let mux-gate-body = {
  line(
    (-0.5, 0.8),
    (-0.5, -0.8),
    (0.5, -0.6),
    (0.5, 0.6),
    (-0.5, 0.8)
  )
  anchors((
    "bin 1": (-0.5, 0.3),
    "in 1": (rel: (-0.5, 0)),
    "bin 2": (-0.5, -0.3),
    "in 2": (rel: (-0.5, 0)),
    "bsel": (0, 0.7),
    "sel": (rel: (0, 0.3)),
    "bout": (0.5, 0),
    "out": (rel: (0.5, 0)),
    "north": (0, 0.7),
    "south": (0, -0.7),
    "east": "out",
    "west": ("in 1", "|-", "center"),
    "left": ("bin 1", "|-", "center"),
    "right": "bout"
  ))
}

#let dec-gate-body = {
  line(
    (-0.5, 0.6),
    (-0.5, -0.6),
    (0.5, -0.8),
    (0.5, 0.8),
    (-0.5, 0.6)
  )
  anchors((
    "bin": (-0.5, 0),
    "in": (rel: (-0.5, 0)),
    "bout 1": (0.5, 0.3),
    "out 1": (rel: (0.5, 0)),
    "bout 2": (0.5, -0.3),
    "out 2": (rel: (0.5, 0)),
    "north": (0, 0.7),
    "south": (0, -0.7),
    "east": (0.5, 0),
    "west": ("in", "|-", "center"),
    "left": ("bin", "|-", "center"),
    "right": (0.5, 0)
  ))
}

#let latch-gate-body = {
  line(
    (-0.5, 0.8),
    (-0.5, -0.8),
    (0.5, -0.8),
    (0.5, 0.8),
    (-0.5, 0.8)
  )
  content((-0.3, 0.3), $D$)
  content((0.3, 0.3), $Q$)
  content((0.3, -0.3), $overline(Q)$)
  anchors((
    "bin": (-0.5, 0.3),
    "in": (rel: (-0.5, 0)),
    "bout 1": (0.5, 0.3),
    "out 1": (rel: (0.5, 0)),
    "bout 2": (0.5, -0.3),
    "out 2": (rel: (0.5, 0)),
    "north": (0, 0.8),
    "south": (0, -0.8),
    "east": (0.5, 0),
    "west": ("in", "|-", "center"),
    "left": ("bin", "|-", "center"),
    "right": (0.5, 0)
  ))
}

#let buf-gate-body = {
  line(
    (-0.5, 0.5),
    (-0.5, -0.5),
    (0.5, 0),
    (-0.5, 0.5)
  )
  anchors((
    "bin": (-0.5, 0),
    "in": (rel: (-0.5, 0)),
    "bout": (0.5, 0),
    "out": (rel: (0.5, 0)),
    "north": (0, 0.5),
    "south": (rel: (0, -1)),
    "east": "out",
    "west": ("in", "|-", "center"),
    "left": ("bin", "|-", "center"),
    "right": "bout"
  ))
}

#let and-gate-body = {
  merge-path(close: true, {
    arc((0,0), -90deg, 90deg, radius: 0.5, name: "curve", anchor: "origin")
    line(
      (0, 0.5),
      (-0.5, 0.5),
      (-0.5, -0.5)
    )
  })
  anchors((
    "bin 1": (-0.5, 0.25),
    "in 1": (rel: (-0.5, 0)),
    "bin 2": (-0.5, -0.25),
    "in 2": (rel: (-0.5, 0)),
    "bout": (0.5, 0),
    "out": (rel: (0.5, 0)),
    "north": (0, 0.5),
    "south": (rel: (0, -1)),
    "east": "out",
    "west": ("in 1", "|-", "center"),
    "left": ("bin 1", "|-", "center"),
    "right": "bout"
  ))
}

#let or-gate-body = {
  merge-path(close: true, {
    arc((0.5, 0), -90deg, -30deg, anchor: "end", name: "bcurve")
    arc((0.5,0), 30deg, 90deg, anchor: "start", name: "tcurve")
    line("tcurve.end", (-0.5, 0.5))
    arc((), -30deg, 30deg, anchor: "end")
  })

  // x coordinate of where the input legs touch the body of the gate
  let x = calc.cos(calc.asin(0.25)) - calc.cos(calc.asin(0.5)) - 0.5
  anchors((
    "bin 1": (x, 0.25),
    "in 1": (-1, 0.25),
    "bin 2": (x, -0.25),
    "in 2": (-1, -0.25),
    "bout": (0.5, 0),
    "out": (rel: (0.5, 0)),
    "north": (0, 0.5),
    "south": (rel: (0, -1)),
    "east": "out",
    "west": ("in 1", "|-", "center"),
    "left": ("bin 1", "|-", "center"),
    "right": "bout"
  ))
}

#let not-circle = {
  circle((rel: (0.1, 0), to: "bout"), radius: 0.1)
  anchors((
    "N-not": (),
    "body right": "bout",
    "bout": (rel: (0.2, 0)),
    "right": "bout"
  ))
}

#let xor-bar = {
  arc((-0.6, -0.5), -30deg, 30deg)
  anchors((
    "ibin 1": "bin 1",
    "ibin 2": "bin 2",
    "bin 1": (rel: (-0.1, 0), to: "bin 1"),
    "bin 2": (rel: (-0.1, 0), to: "bin 2"),
    "body left": "left",
    "left": (rel: (-0.1, 0), to: "left")
  ))
}

#let clk-signal = {
  line(
    "north",
    (rel: (0.15, 0)),
    (rel: (-0.15, -0.15)),
    (rel: (-0.15, 0.15))
  )
}

#let logic-gate-legs = for a in ("in 1", "in 2", "out") {
  line("b" + a, a)
}

#let logic-gate-legs-single = for a in ("in", "out") {
  line("b" + a, a)
}

#let logic-gate-legs-mux = for a in ("in 1", "in 2", "out", "sel") {
  line("b" + a, a)
}

#let logic-gate-legs-dec = for a in ("in", "out 1", "out 2") {
  line("b" + a, a)
}

#let logic-gate-legs-add = for a in ("in 1", "in 2", "cin", "out", "cout") {
  line("b" + a, a)
}
>>>>>>> c311ec6 (feat: add multiple logic gates)
