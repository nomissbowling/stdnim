# tstdstring.nim

import unittest
import stdnim
import ../../src/stdnim/private/stdnimcommon
import strformat

proc toSeq(s: StdString): seq[char] =
  for it in s: result.add(it[])

proc run() =
  suite "test StdString":
    var
      vstruct: StdVector[NIMstruct] # dummy (vstruct.size == 0)
      nimstr: string = "testSTDSTR"
      stdstr: StdString = newStdString(cast[cstring](nimstr[0].addr))
      immstr: StdString = newStdString("direct")

    test "test StdString (front)":
      echo fmt"stdstr: {stdstr.size} {$stdstr}"
      echo fmt"immstr: {immstr.size} {$immstr}"

      check(front(vstruct, stdstr) == 1)
      check(front(vstruct, immstr) == 1)

    test "test StdVector (process)":
      echo fmt"stdstr: {stdstr.size} {$stdstr}"
      echo fmt"immstr: {immstr.size} {$immstr}"

      echo stdstr[3]
      stdstr[3] = 'x'
      echo immstr[4]
      immstr[4] = 'x'
      var pc: ptr char = immstr.at(3)
      pc[] = 'y'
      echo fmt"(ptr) immstr size: {immstr.addr[].size}"

      echo stdstr.toSeq

      echo fmt"stdstr: {stdstr.size} {$stdstr}"
      echo fmt"immstr: {immstr.size} {$immstr}"

    test "test StdString (back)":
      check(back(vstruct, stdstr) == 0)
      check(back(vstruct, immstr) == 0)

      echo fmt"stdstr: {stdstr.size} {$stdstr}"
      echo fmt"immstr: {immstr.size} {$immstr}"

      check($stdstr == "!esxSTDSTz")
      check($immstr == "!iryxz")

      echo stdstr.repr
      echo immstr.repr
      echo vstruct.repr

run()
