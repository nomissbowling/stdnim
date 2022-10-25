mode = ScriptMode.Verbose

packageName   = "stdnim"
version       = "0.0.1"
author        = "nomissbowling"
description   = "bindings to C++ std classes for Nim"
license       = "MIT"
skipDirs      = @["tests", "benchmarks", "htmldocs"]
skipFiles     = @["_config.yml"]

requires "nim >= 1.0.0"

proc configForTests() =
  --hints: off
  --linedir: on
  --stacktrace: on
  --linetrace: on
  --debuginfo
  --path: "."
  --run

proc configForBenchmarks() =
  --define: release
  --path: "."
  --run

task test, "run tests":
  configForTests()
  setCommand "c", "tests/tAll.nim"

task testAll, "run All tests":
  configForTests()
  setCommand "c", "tests/tAll.nim"

task benchmark, "run benchmarks":
  configForBenchmarks()
  setCommand "c", "benchmarks/bAll.nim"

task docs, "generate documentation":
  exec("mkdir -p htmldocs/stdnim")
  --project
  --git.url: "https://github.com/nomissbowling/stdnim"
  --git.commit: master
  setCommand "doc", "stdnim.nim"
