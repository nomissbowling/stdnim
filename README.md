stdnim
======

bindings to C++ std classes for Nim


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
  # TODO: vstruct.items
  # for it in vstruct:
  for it in vstruct.begin..<vstruct.end:
    let struct: NIMstruct = it[]
    r.add(fmt"vec size: {struct.vec.size} {$struct.txt.cStr}")

    block:
      for pt in struct.vec.begin..<struct.vec.end:
        let p: NIMpoint = pt[]
        r.add(fmt" {p}")

    block:
      let m: StdMap[StdString, NIMpoint] = struct.mapo
      var mt = m.begin
      while mt != m.end:
        let sp: StdPair[StdString, NIMpoint] = mt[]
        r.add(fmt" mo[{$sp.first[].cStr}] {$sp.second[]}")
        mt = mt.next

    block:
      let m: StdUoMap[StdString, NIMpoint] = struct.mapuo
      var mt = m.begin
      while mt != m.end:
        let sp: StdPair[StdString, NIMpoint] = mt[]
        r.add(fmt" mu[{$sp.first[].cStr}] {$sp.second[]}")
        mt = mt.next

    block:
      let sp: StdPair[StdString, NIMpoint] = struct.pairsp
      r.add(fmt" {$sp.first[].cStr}: {$sp.second[]}")

  result = r.join("\n")
```


License
-------

MIT License

