# tstduomap.nim

import unittest
import stdnim
import ../../src/stdnim/private/stdnimcommon
import strformat, strutils

proc toStr(vstruct: StdVector[NIMstruct]): string=
  var r = @[fmt"vstruct size: {vstruct.size}"]
  # TODO: vstruct.items
  # for it in vstruct:
  for it in vstruct.begin..<vstruct.end:
    let struct: NIMstruct = it[]
    let m: StdUoMap[StdString, NIMpoint] = struct.mapuo
    #for mt in m.begin..<m.end: # not define operator< for unordered_map
    var mt = m.begin
    while mt != m.end:
      let sp: StdPair[StdString, NIMpoint] = mt[]
      r.add(fmt" [{$sp.first[].cStr}] {$sp.second[]}")
      mt = mt.next
  result = r.join("\n")

proc cmp(vstruct: StdVector[NIMstruct],
  estruct: seq[seq[tuple[k: string, v: seq[int]]]]): bool=
  result = true
  var i = 0
  for it in vstruct.begin..<vstruct.end:
    let struct: NIMstruct = it[]
    let m: StdUoMap[StdString, NIMpoint] = struct.mapuo
    var j = 0
    #for mt in m.begin..<m.end: # not define operator< for unordered_map
    var mt = m.begin
    while mt != m.end:
      let sp: StdPair[StdString, NIMpoint] = mt[]
      let et: tuple[k: string, v: seq[int]] = estruct[i][j]
      if et.k != $sp.first[].cStr or
        et.v[0] != sp.second[].x or et.v[1] != sp.second[].y:
        result = false
        return
      j += 1
      mt = mt.next
    i += 1

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
          ("Beta", @[2055, 11]),
          ("alpha", @[2033, 77]),
          ("ccc", @[2033, 33]),
          ("D", @[2000, 2033])]]

    test "test StdUoMap (front)":
      check(front(vstruct, dumstr) == 1)

    test "test StdUoMap (process)":
      echo vstruct.toStr

      var ps: ptr NIMstruct = vstruct.at(1)
      var pm: ptr StdUoMap[StdString, NIMpoint] = ps[].mapuo.addr

      echo vstruct.toStr

    test "test StdUoMap (back)":
      check(back(vstruct, dumstr) == 0)

      echo vstruct.toStr

      check(vstruct.cmp(estruct))

run()