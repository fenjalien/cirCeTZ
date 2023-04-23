#import "../typst-canvas/draw.typ": *

#import "parts.typ"

#let geographical-anchors(pts) = {
    assert(type(pts) == "array" and pts.len() == 8, message: "Invalid format for geographical anchor positions " + repr(pts))
    let headings = ("west", "north west", "north", "north east", "east", "south east", "south", "south west")
    for i in range(0, 8) {
        anchor(headings.at(i), pts.at(i))
    }
}

/// Resistive bipoles

/// Short circuit 
/// type: path-style
/// nodename: shortshape
#let short = {
  line("inner.start", "inner.end")
}

/// Resistor
/// type: path-style
/// nodename: resistorshape
#let R = {
  let x = 1.4/6
  let y = 0.5
  line(
    "inner.start",
    (rel: (x/2, y/2)),
    (rel: (x, -y)),
    (rel: (x, y)),
    (rel: (x, -y)),
    (rel: (x, y)),
    (rel: (x, -y)),
    (rel: (x/2, y/2)),
  )
  anchor("label", "inner.center")
  anchor("label", (rel:(0, 0.5)))
  anchor("annotation", (rel:(0, -1)))
  geographical-anchors((
      "inner.start",
      (rel: (0, 0.5)),
      (rel: (0.7 ,0)),
      (rel: (0.7, 0)),
      "inner.end",
      (rel: (0, -0.5)),
      (rel: (-0.7, 0)),
      (rel: (-0.7, 0)),
  ))
}


// Capacitors and inductors
// Diodes and such
// Sources and generators

/// Current source
/// type: path-style, fillable
#let isource = {
  circle("inner.center", radius: 0.5, name: "c")
  line("inner.start", (rel: (0.2, 0)))
  fill(black)
  line((rel: (0.2, 0)), (rel: (0.6, 0)), mark-end: ">")
  line("inner.end", (rel: (-0.2, 0)))

  anchor("label", "inner.center")
  anchor("label", (rel:(0, 0.7)))
  anchor("annotation", (rel:(0, -1.4)))

  geographical-anchors((
      "inner.start",
      (rel: (0, 0.5)),
      (rel: (0.7 ,0)),
      (rel: (0.7, 0)),
      "inner.end",
      (rel: (0, -0.5)),
      (rel: (-0.7, 0)),
      (rel: (-0.7, 0)),
  ))
}

/// Arrows

/// Arrow for current and voltage
/// type: node
#let currarrow = {
  fill(black)
  line(
    (rel: (0.05, 0)),
    (rel: (-0.1, -0.05)),
    (rel: (0, 0.1)),
    close: true
    
  )
}


/// Terminal shapes

/// Unconnected terminal
/// type: node
#let ocirc = {
  circle((), radius: 0.05)
  geographical-anchors(
    (
      (rel: (-0.05, 0)),
      (rel: (0, 0.05)),
      (rel: (0.05, 0)),
      (rel: (0.05, 0)),
      (rel: (0, -0.05)),
      (rel: (0, -0.05)),
      (rel: (-0.05, 0)),
      (rel: (-0.05, 0)),
    )
  )
}

/// Connected terminal
/// type: node 
#let circ = {
    fill(black)
    ocirc
}

/// Diamond-square terminal
/// type: node
#let diamondpole = {
  fill(black)
  line(
    "center",
    (rel: (0.05, 0)),
    (rel: (0, -0.05)),
    (rel: (-0.05, 0)),
    close: true
    )
}

/// Square-shape terminal
/// type: node
#let squarepole = {
  fill(black)
  rect(
    (-0.05, 0.05),
    (0.05, -0.05)
  )
}

/// Logic gates

/// AND gate
/// type: node, fillable
#let and-gate = {
  parts.and-gate-body
  parts.logic-gate-legs
}

/// NAND gate
/// type: node, fillable
#let nand-gate = {
  parts.and-gate-body
  move-to("bout")
  circle((rel: (0.1, 0)), radius: 0.1)
  anchor("bout", (rel: (0.1, 0)))
  parts.logic-gate-legs
}

/// OR gate
/// type: node, fillable
#let or-gate = {
  parts.or-gate-body
  parts.logic-gate-legs
}

/// NOR gate
/// type: node, fillable
#let nor-gate = {
  parts.or-gate-body
  move-to("bout")
  circle((rel: (0.1, 0)), radius: 0.1)
  anchor("bout", (rel: (0.1, 0)))
  parts.logic-gate-legs
}

/// XOR gate
/// type: node, fillable
#let xor-gate = {
  parts.or-gate-body
  arc((rel: (-1.6, 0.5)), 60deg, 120deg)
  parts.logic-gate-legs
}

#let path = (
  // Resistive bipoles
  "short": short,
  "R": R,

  // Sources and generators
  "isource": isource,
)

#let node = (
  // Arrows
  "currarrow": currarrow,

  //Terminal Shapes
  "circ": circ,
  "diamondpole": diamondpole,
  "squarepole": squarepole,

  // Logic gates
  "and gate": and-gate,
  "nand gate": nand-gate,
  "or gate": or-gate,
  "nor gate": nor-gate,
  "xor gate": xor-gate
  // "and gate": {
  //   subcomponents.at("and gate body")
  //   line((-0.5, 0.25), (rel: (-0.5, 0)), name: "1")
  //   line((-0.5, -0.25), (rel: (-0.5, 0)), name: "2")
  //   line((0.5, 0), (rel: (0.5, 0)), name: "3")
  //   anchor("in 1", "1.end")
  //   anchor("bin 1", "1.start")
  //   anchor("in 2", "2.end")
  //   anchor("bin 2", "2.start")
  //   anchor("out", "3.end")
  //   anchor("bout", "3.start")
  // },
  // "or gate": {
  //   subcomponents.at("or gate body")
  //   // x coordinate of where the input legs touch the body of the gate
  //   let x = calc.cos(calc.asin(0.25)) - calc.cos(calc.asin(0.5)) - 0.5
  //   line((x, 0.25), (-1, 0.25), name: "1")
  //   line((x, -0.25), (-1, -0.25), name: "2")
  //   line((0.5, 0), (1, 0), name: "3")

  //   anchor("in 1", "1.end")
  //   anchor("bin 1", "1.start")
  //   anchor("in 2", "2.end")
  //   anchor("bin 2", "2.start")
  //   anchor("out", "3.end")
  //   anchor("bout", "3.start")
  // },
  // "nand gate": {
  //   subcomponents.at("and gate body")
  //   circle("curve.right", radius: 0.1, anchor: "left", name: "circle")
    
  //   line((-0.5, 0.25), (rel: (-0.5, 0)), name: "1")
  //   line((-0.5, -0.25), (rel: (-0.5, 0)), name: "2")
  //   line("circle.right", (1, 0), name: "3")
    
  //   anchor("in 1", "1.end")
  //   anchor("bin 1", "1.start")
  //   anchor("in 2", "2.end")
  //   anchor("bin 2", "2.start")
  //   anchor("out", "3.end")
  //   anchor("bout", "3.start")
  // },
  // "xor gate": {
  //   subcomponents.at("or gate body")
  //   arc((-0.6, 0.5), 60deg, 120deg)
    
  //   // x coordinate of where the input legs touch the body of the gate
  //   let x = calc.cos(calc.asin(0.25)) - calc.cos(calc.asin(0.5)) - 0.5
  //   line((x, 0.25), (-1, 0.25), name: "1")
  //   line((x, -0.25), (-1, -0.25), name: "2")
  //   line((0.5, 0), (1, 0), name: "3")

  //   anchor("in 1", "1.end")
  //   anchor("bin 1", "1.start")
  //   anchor("in 2", "2.end")
  //   anchor("bin 2", "2.start")
  //   anchor("out", "3.end")
  //   anchor("bout", "3.start")
  // },
)
