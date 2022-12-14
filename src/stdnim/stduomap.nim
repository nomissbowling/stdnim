# stduomap.nim

import strformat, strutils
import stdpair

{.push header: "<unordered_map>".}
type
  StdUoMap*[K, V] {.importcpp: "std::unordered_map".} = object
  StdUoMapIterator*[K, V]
    {.importcpp: "std::unordered_map<'0, '1>::iterator".} = object

proc newStdUoMap*[K, V](): StdUoMap[K, V]
  {.importcpp: "std::unordered_map<'*0, '*1>(@)", constructor.}

proc size*(m: StdUoMap): csize_t {.importcpp: "size".}
# proc size*(m: ptr StdUoMap): csize_t {.importcpp: "#->size()".}
proc clear*[K, V](m: var StdUoMap[K, V]) {.importcpp: "clear".}

proc begin*[K, V](m: StdUoMap[K, V]): StdUoMapIterator[K, V]
  {.importcpp: "begin".}
proc `end`*[K, V](m: StdUoMap[K, V]): StdUoMapIterator[K, V]
  {.importcpp: "end".}
proc `[]`*[K, V](it: StdUoMapIterator[K, V]): StdPair[K, V]
  {.importcpp: "(*#)".}
proc inc*[K, V](it: var StdUoMapIterator[K, V])
  {.importcpp: "(++#)".}
proc next*[K, V](it: StdUoMapIterator[K, V]; n: clonglong=1): StdUoMapIterator[K, V]
  {.importcpp: "next(@)".}
proc `!=`*[K, V](a, b: StdUoMapIterator[K, V]): bool
  {.importcpp: "operator!=(@)".}
# TODO: not define operator< and operator<= for unordered_map
#proc `<`*[K, V](a, b: StdUoMapIterator[K, V]): bool
#  {.importcpp: "operator<(@)".}
#proc `<=`*[K, V](a, b: StdUoMapIterator[K, V]): bool
#  {.importcpp: "operator<=(@)".}

proc `[]`*[K, V](m: StdUoMap[K, V], k: K): StdPair[K, V]
  {.importcpp: "#[#]".}
proc `[]`*[K, V](m: ptr StdUoMap[K, V], k: K): ptr StdPair[K, V]
  {.importcpp: "&(*#)[#]".}

proc `[]=`*[K, V](m: var StdUoMap[K, V], k: K, v: V)
  {.importcpp: "#[#]=#".}
proc `[]=`*[K, V](m: ptr StdUoMap[K, V], k: K, v: V)
  {.importcpp: "(*#)[#]=#".}

{.pop.}

iterator items*[K, V](m: StdUoMap[K, V]): StdUoMapIterator[K, V] =
  var it = m.begin
  while it != m.end:
    yield it
    it = it.next

iterator pairs*[K, V](m: StdUoMap[K, V]): tuple[key: int, it: StdUoMapIterator[K, V]] =
  var i = 0
  var it = m.begin
  while it != m.end:
    yield (i, it)
    it = it.next
    i += 1

proc `$`*[K, V](m: StdUoMap[K, V]): string =
  var r: seq[string] = @[]
  for it in m: r.add(it[].repr)
  let
    s = r.join(",\n")
    t = if m.len > 0: "\n" else: ""
  result = fmt"{'\x7b'}{t}{s}{'\x7d'}"

template repr*[K, V](m: StdUoMap[K, V]): string =
  $m

template len*[K, V](m: StdUoMap[K, V]): int =
  m.size.int
