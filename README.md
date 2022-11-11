stdnim
======

bindings to C++ std classes string vector pair map unordered_map for Nim


now supports
------------

a part of std::vector

a part of std::string

a part of std::pair

a part of std::map

a part of std::unordered_map


usage
-----

```nim
import stdnim

type
  NIMpoint* = tuple[x: cint, y: cint]

  NIMstruct* = object
    txt*: StdString
    vec*: StdVector[NIMpoint]
    mapo*: StdMap[StdString, NIMpoint]
    mapuo*: StdUoMap[StdString, NIMpoint]
    pairsp*: StdPair[StdString, NIMpoint]

proc toStr(vstruct: StdVector[NIMstruct]): string=
  var r = @[fmt"vstruct size: {vstruct.size}"]
  for it in vstruct:
    let struct: NIMstruct = it[]
    r.add(fmt"vec size: {struct.vec.size} {$struct.txt}")

    block:
      for pt in struct.vec:
        let p: NIMpoint = pt[]
        r.add(fmt" {p}")

    block:
      let m: StdMap[StdString, NIMpoint] = struct.mapo
      for mt in m:
        let sp: StdPair[StdString, NIMpoint] = mt[]
        r.add(fmt" mo[{$sp.first[]}] {$sp.second[]}")

    block:
      let m: StdUoMap[StdString, NIMpoint] = struct.mapuo
      for mt in m:
        let sp: StdPair[StdString, NIMpoint] = mt[]
        r.add(fmt" mu[{$sp.first[]}] {$sp.second[]}")

    block:
      let sp: StdPair[StdString, NIMpoint] = struct.pairsp
      r.add(fmt" {$sp.first[]}: {$sp.second[]}")

  result = r.join("\n")
```


License
-------

MIT License

