mode = ScriptMode.Verbose

# Package

packageName   = "stdnim"
version       = "0.0.1"
author        = "nomissbowling"
description   = "bindings to C++ std classes for Nim"
license       = "MIT"
srcDir        = "src"
skipDirs      = @["tests", "benchmarks", "htmldocs"]
skipFiles     = @["_config.yml"]

# Dependencies

requires "nim >= 1.0.0"

# Scripts

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
  setCommand "c", "tests/tStdAll.nim"

task testAll, "run StdAll tests":
  configForTests()
  setCommand "c", "tests/tStdAll.nim"

task benchmark, "run benchmarks":
  configForBenchmarks()
  setCommand "c", "benchmarks/bStdAll.nim"

task docs, "generate documentation":
  exec("mkdir -p htmldocs/stdnim")
  --project
  --git.url: "https://github.com/nomissbowling/stdnim"
  --git.commit: master
  setCommand "doc", "stdnim.nim"
