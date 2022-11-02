# tstdvector.nim

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
    r.add(fmt"vec size: {struct.vec.size} {$struct.txt.cStr}")
    for pt in struct.vec.begin..<struct.vec.end:
      let p: NIMpoint = pt[]
      r.add(fmt" {p}")
  result = r.join("\n")

proc cmp(vstruct: StdVector[NIMstruct], estruct: seq[seq[seq[int]]]): bool=
  result = true
  var i = 0
  for it in vstruct.begin..<vstruct.end:
    var j = 0
    let struct: NIMstruct = it[]
    for pt in struct.vec.begin..<struct.vec.end:
      let p: NIMpoint = pt[]
      if estruct[i][j][0] != p.x or estruct[i][j][1] != p.y:
        result = false
        return
      j += 1
    i += 1

proc run() =
  suite "test StdVector":
    var
      vstruct: StdVector[NIMstruct]
      dumstr: StdString = newStdString("*StdVector") # [0] == '*'

    let
      estruct = @[
        @[
          @[11, 2],
          @[12, 3],
          @[13, 4],
          @[14, 5],
          @[15, 6]],
        @[
          @[12, 3],
          @[13, 4],
          @[14, 5],
          @[60, 16], # @[15, 6], # overwrite test
          @[16, 7]]]

    test "test StdVector (front)":
      check(front(vstruct, dumstr) == 1)

    test "test StdVector (process)":
      echo vstruct.toStr

      var ps: ptr NIMstruct = vstruct.at(1)
      ps[].txt.at(2)[] = 'x'
      var pv: ptr StdVector[NIMpoint] = ps[].vec.addr
      echo fmt"(ptr) vec size: {pv[].size} {$ps[].txt.cStr}"
      var pp: ptr NIMpoint = pv[].at(3) # allows pv.at(3) too
      pp[].x *= 10
      pp[].y += 10

      echo vstruct.toStr

    test "test StdVector (back)":
      check(back(vstruct, dumstr) == 0)

      echo vstruct.toStr

      check(vstruct.cmp(estruct))

run()
