# tstdstring.nim

import unittest
import stdnim
import ../../src/stdnim/private/stdnimcommon
import strformat

proc run() =
  suite "test StdString":
    var
      vstruct: StdVector[NIMstruct] # dummy (vstruct.size == 0)
      nimstr: string = "testSTDSTR"
      stdstr: StdString = newStdString(cast[cstring](nimstr[0].addr))
      immstr: StdString = newStdString("direct")

    test "test StdString (front)":
      echo fmt"stdstr: {stdstr.size} {$stdstr.cStr}"
      echo fmt"immstr: {immstr.size} {$immstr.cStr}"

      check(front(vstruct, stdstr) == 1)
      check(front(vstruct, immstr) == 1)

    test "test StdVector (process)":
      echo fmt"stdstr: {stdstr.size} {$stdstr.cStr}"
      echo fmt"immstr: {immstr.size} {$immstr.cStr}"

      echo stdstr[3]
      stdstr[3] = 'x'
      echo immstr[4]
      immstr[4] = 'x'
      var pc: ptr char = immstr.at(3)
      pc[] = 'y'
      echo fmt"(ptr) immstr size: {immstr.addr[].size}"

      # TODO: stdstr.items
      # for it in stdstr:
      # for it in stdstr.begin..<stdstr.end:
      #   echo $it[]

      echo fmt"stdstr: {stdstr.size} {$stdstr.cStr}"
      echo fmt"immstr: {immstr.size} {$immstr.cStr}"

    test "test StdString (back)":
      check(back(vstruct, stdstr) == 0)
      check(back(vstruct, immstr) == 0)

      echo fmt"stdstr: {stdstr.size} {$stdstr.cStr}"
      echo fmt"immstr: {immstr.size} {$immstr.cStr}"

      check($stdstr.cStr == "!esxSTDSTz")
      check($immstr.cStr == "!iryxz")

run()
