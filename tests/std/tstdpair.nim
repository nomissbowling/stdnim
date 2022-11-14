# tstdpair.nim

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
    let sp: StdPair[StdString, NIMpoint] = struct.pairsp
    r.add(fmt" {$sp.first[]}: {$sp.second[]}")
  result = r.join("\n")

proc cmp(vstruct: StdVector[NIMstruct],
  estruct: seq[tuple[k: string, v: seq[int]]]): bool=
  result = true
  for i, it in vstruct:
    let struct: NIMstruct = it[]
    let sp: StdPair[StdString, NIMpoint] = struct.pairsp
    if estruct[i].k != $sp.first[] or
      estruct[i].v[0] != sp.second[].x or estruct[i].v[1] != sp.second[].y:
      result = false
      return

proc run() =
  suite "test StdPair":
    var
      vstruct: StdVector[NIMstruct]
      dumstr: StdString = newStdString("*StdPair") # [0] == '*'

    let
      estruct = @[
        ("test key abc", @[102, 303]),
        ("tEst key abc", @[1104, 3306])]

    test "test StdPair (front)":
      check(front(vstruct, dumstr) == 1)

    test "test StdPair (process)":
      echo vstruct.toStr

      var ps: ptr NIMstruct = vstruct.at(1)
      var psp: ptr StdPair[StdString, NIMpoint] = ps[].pairsp.addr
      var pspk: ptr StdString = psp.first
      var pspv: ptr NIMpoint = psp.second
      pspk.at(1)[] = 'E'; pspv[].x += 1000; pspv[].y += 3000

      echo vstruct.toStr

    test "test StdPair (back)":
      check(back(vstruct, dumstr) == 0)

      echo vstruct.toStr

      check(vstruct.cmp(estruct))

      echo vstruct.repr
      echo dumstr.repr

run()
