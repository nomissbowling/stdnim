# tstduomap.nim

import unittest
import stdnim
import ../../src/stdnim/private/stdnimcommon
import strformat, strutils

proc toStr(vstruct: StdVector[NIMstruct]): string=
  var r = @[fmt"vstruct size: {vstruct.size}"]
  for it in vstruct:
    let struct: NIMstruct = it[]
    let m: StdUoMap[StdString, NIMpoint] = struct.mapuo
    for mt in m:
      let sp: StdPair[StdString, NIMpoint] = mt[]
      r.add(fmt" [{$sp.first[]}] {$sp.second[]}")
  result = r.join("\n")

proc cmp(vstruct: StdVector[NIMstruct],
  estruct: seq[seq[tuple[k: string, v: seq[int]]]]): bool=
  result = true
  for i, it in vstruct:
    let struct: NIMstruct = it[]
    let m: StdUoMap[StdString, NIMpoint] = struct.mapuo
    for j, mt in m:
      let sp: StdPair[StdString, NIMpoint] = mt[]
      let et: tuple[k: string, v: seq[int]] = estruct[i][j]
      if et.k != $sp.first[] or
        et.v[0] != sp.second[].x or et.v[1] != sp.second[].y:
        result = false
        return

proc run() =
  suite "test StdUoMap":
    var
      vstruct: StdVector[NIMstruct]
      dumstr: StdString = newStdString("*StdUoMap") # [0] == '*'

    let
      estruct = @[ # not fixed order by unordered_map
        @[
          ("Beta", @[1055, 11]),
          ("alpha", @[1033, 77]),
          ("ccc", @[1033, 33]),
          ("D", @[1000, 1033])],
        @[
          ("F", @[2222, 2000]),
          ("Beta", @[2055, 11]),
          ("ee", @[2345, 2222]),
          ("alpha", @[2333, 7777]),
          ("ccc", @[2033, 33]),
          ("D", @[2000, 2033])]]

    test "test StdUoMap (front)":
      check(front(vstruct, dumstr) == 1)

    test "test StdUoMap (process)":
      echo vstruct.toStr

      # to change C++ value from Nim, use ptr
      var ps: ptr NIMstruct = vstruct.at(1)
      ps[].mapuo[newStdString("F")] = (2222.cint, 2000.cint)
      var pm: ptr StdUoMap[StdString, NIMpoint] = ps[].mapuo.addr
      pm[newStdString("alpha")] = (2333.cint, 7777.cint)
      pm[newStdString("ee")] = (2345.cint, 2222.cint)

      echo pm[].repr
      echo vstruct.toStr

    test "test StdUoMap (back)":
      check(back(vstruct, dumstr) == 0)

      echo vstruct.toStr

      check(vstruct.cmp(estruct))

      echo vstruct.repr
      echo dumstr.repr

run()
