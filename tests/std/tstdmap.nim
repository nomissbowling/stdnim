# tstdmap.nim

import unittest
import stdnim
import ../../src/stdnim/private/stdnimcommon
import strformat, strutils

proc toStr(vstruct: StdVector[NIMstruct]): string=
  var r = @[fmt"vstruct size: {vstruct.size}"]
  for it in vstruct:
    let struct: NIMstruct = it[]
    let m: StdMap[StdString, NIMpoint] = struct.mapo
    for mt in m:
      let sp: StdPair[StdString, NIMpoint] = mt[]
      r.add(fmt" [{$sp.first[].cStr}] {$sp.second[]}")
  result = r.join("\n")

proc cmp(vstruct: StdVector[NIMstruct],
  estruct: seq[seq[tuple[k: string, v: seq[int]]]]): bool=
  result = true
  var i = 0
  for it in vstruct:
    let struct: NIMstruct = it[]
    let m: StdMap[StdString, NIMpoint] = struct.mapo
    var j = 0
    for mt in m:
      let sp: StdPair[StdString, NIMpoint] = mt[]
      let et: tuple[k: string, v: seq[int]] = estruct[i][j]
      if et.k != $sp.first[].cStr or
        et.v[0] != sp.second[].x or et.v[1] != sp.second[].y:
        result = false
        return
      j += 1
    i += 1

proc run() =
  suite "test StdMap":
    var
      vstruct: StdVector[NIMstruct]
      dumstr: StdString = newStdString("*StdMap") # [0] == '*'

    let
      estruct = @[ # fixed order by map
        @[
          ("Beta", @[105, 1]),
          ("D", @[100, 103]),
          ("alpha", @[103, 7]),
          ("ccc", @[103, 3])],
        @[
          ("Beta", @[205, 1]),
          ("D", @[200, 203]),
          ("F", @[222, 200]),
          ("alpha", @[233, 777]),
          ("ccc", @[203, 3]),
          ("ee", @[234, 222])]]

    test "test StdMap (front)":
      check(front(vstruct, dumstr) == 1)

    test "test StdMap (process)":
      echo vstruct.toStr

      # to change C++ value from Nim, use ptr
      var ps: ptr NIMstruct = vstruct.at(1)
      ps[].mapo[newStdString("F")] = (222.cint, 200.cint)
      var pm: ptr StdMap[StdString, NIMpoint] = ps[].mapo.addr
      pm[newStdString("ee")] = (234.cint, 222.cint)
      pm[newStdString("alpha")] = (233.cint, 777.cint)

      echo vstruct.toStr

    test "test StdMap (back)":
      check(back(vstruct, dumstr) == 0)

      echo vstruct.toStr

      check(vstruct.cmp(estruct))

run()
