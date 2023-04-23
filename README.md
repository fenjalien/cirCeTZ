# circuitypst

A port of [`circuitikz`](https://github.com/circuitikz/circuitikz) to Typst using [`typst-canvas`](https://github.com/johannes-wolf/typst-canvas). Due to the size of `circuitikz` features will be ported as I need them for my own work, if theres a feature you need feel free to make an issue, PR or contact me through Typst's discord (same username)!

![](assets/current%20shunt.png)

## "Installation"
Because of Typst's current lack of package management the library expects to be placed in the same folder as `typst-canvas`.
```
typst-canvas/
circuitypst/
```
You can either clone the repository or download it as a `.zip` and extract it to the required location.

## Usage
To get started `node` and `to` should be imported from `circuitypst.typ`, ideally inside `typst-canvas`'s `canvas` function.

Here is a template:
```typ
#import "typst-canvas/canvas.typ": canvas

#canvas(length: 1cm, debug: false, {
  import "typst-canvas/draw.typ": *
  import "circuitypst/circuitypst.typ": node, to
  ...
})
```
Also see `examples/` for some examples. 

## Requirements for First Stable Release
- [ ] Reference manual (doesn't have to inclued tutorials, just a list of currently supported components)
- [ ] Tests
- [ ] CI
- [ ] More components?
