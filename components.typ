#import "@preview/cetz:0.0.1"

#import cetz.draw: line, circle, fill, rect

#import "parts.typ"
#import "utils.typ": anchors

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
/// class: default
#let short = {
  line((-0.5, 0), (0.5, 0))
  anchors((
    north: (0,0),
    south: (0,0),
    label: (0,0),
    annotation: (0,0),
  ))
}

/// Resistor
/// type: path-style
/// nodename: resistorshape
/// Aliases: american resistor
/// Class: resistors
#let R = {
  let step = 1/6
  let height = 5/14
  let sgn = -1
  line(
    (-0.5, 0),
    (rel: (step/2, height/2)),
    ..for _ in range(5) {
      ((rel: (step, height * sgn)),)
      sgn *= -1
    },
    (0.5, 0),
    fill: none
  )
  anchors((
    north: (0, height/2),
    south: (0, -height/2),
    label: (0, height),
    annotation: "south"
  ))
}


// Capacitors and inductors
// Diodes and such
// Sources and generators

/// American Current Source
/// type: path-style, fillable
/// nodename: isourceAMshape
/// aliases: american current source
/// class: sources
#let isourceAM = {
  circle((0,0), radius: 0.5, name: "c")
  line(((-0.3, 0)), (rel: (0.6, 0)), mark-end: ">", fill: black)

  anchors((
    north: (0, 0.5),
    south: (0, -0.5),
    label: (0, 0.7),
    annotation: (0, -0.7),
  ))
}

/// Arrows

/// Arrow for current and voltage
/// type: node
#let currarrow = {
  line(
    (0.05, 0),
    (-0.05, -0.05),
    (-0.05, 0.05),
    close: true,
    fill: black
  )
  anchors((
    north: (0, 0.05),
    south: (0, -0.05),
    east: (0.05, 0),
    west: (-0.05, 0),
  ))
}


/// Terminal shapes

/// Unconnected terminal
/// type: node
#let ocirc = {
  circle((0, 0), radius: 0.05, stroke: black)
  anchors((
    north: (0, 0.05),
    south: (0, -0.05),
    east: (0.05, 0),
    west: (-0.05, 0),
  ))
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
  anchors((
    north: (0, 0.05),
    south: (0, -0.05),
    east: (0.05, 0),
    west: (-0.05, 0),
  ))
  line(
    "north",
    "east",
    "south",
    "west",
    close: true
  )
}

/// Square-shape terminal
/// type: node
#let squarepole = {
  fill(black)
  rect(
    (-0.05, -0.05),
    (0.05, 0.05)
  )
  anchors((
    north: (0, 0.05),
    south: (0, -0.05),
    east: (0.05, 0),
    west: (-0.05, 0),
  ))
}

/// Amplifiers

/// Operational amplifier
#let op-amp = {
  line(
    (0.8, 0),
    (-0.8, -1),
    (-0.8, 1),
    close: true
  )

  

  anchors((
    north: (0, 1),
    south: (0, -1),
    east: (1, 0),
    west: (-1, 0),
  ))
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
  parts.not-circle
  // circle((rel: (0.1, 0), to: "bout"), radius: 0.1)
  // anchor("bout", (rel: (0.1, 0)))
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
  parts.not-circle
  parts.logic-gate-legs
}

/// XOR gate
/// type: node, fillable
#let xor-gate = {
  parts.or-gate-body
  parts.logic-gate-legs
  parts.xor-bar
}

/// XNOR gate
/// type: node, fillable
#let xnor-gate = {
  parts.or-gate-body
  parts.not-circle
  parts.logic-gate-legs
  parts.xor-bar
}

#let path = (
  // Resistive bipoles
  "short": short,
  "R": R,

  // Sources and generators
  "isourceAM": isourceAM,
)

#let node = (
  // Arrows
  "currarrow": currarrow,

  //Terminal Shapes
  "circ": circ,
  "ocirc": ocirc,
  "diamondpole": diamondpole,
  "squarepole": squarepole,

  // Amplifiers
  "op amp": op-amp,

  // Logic gates
  "and gate": and-gate,
  "nand gate": nand-gate,
  "or gate": or-gate,
  "nor gate": nor-gate,
  "xor gate": xor-gate,
  "xnor gate": xnor-gate
)
