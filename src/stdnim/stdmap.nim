# stdmap.nim

import stdpair

{.push header: "<map>".}
type
  StdMap*[K, V] {.importcpp: "std::map".} = object
  StdMapIterator*[K, V]
    {.importcpp: "std::map<'0, '1>::iterator".} = object

proc newStdMap*[K, V](): StdMap[K, V]
  {.importcpp: "std::map<'*0, '*1>(@)", constructor.}

proc size*(m: StdMap): csize_t {.importcpp: "size".}
# proc size*(m: ptr StdMap): csize_t {.importcpp: "#->size()".}
proc clear*[K, V](m: var StdMap[K, V]) {.importcpp: "clear".}

proc begin*[K, V](m: StdMap[K, V]): StdMapIterator[K, V]
  {.importcpp: "begin".}
proc `end`*[K, V](m: StdMap[K, V]): StdMapIterator[K, V]
  {.importcpp: "end".}
proc `[]`*[K, V](it: StdMapIterator[K, V]): StdPair[K, V]
  {.importcpp: "(*#)".}
proc inc*[K, V](it: var StdMapIterator[K, V])
  {.importcpp: "(++#)".}
proc next*[K, V](it: StdMapIterator[K, V]; n: clong=1): StdMapIterator[K, V]
  {.importcpp: "next(@)".}
proc `!=`*[K, V](a, b: StdMapIterator[K, V]): bool
  {.importcpp: "operator!=(@)".}
# TODO: define operators for K to correct operator< and operator<= for map
proc `<`*[K, V](a, b: StdMapIterator[K, V]): bool
  {.importcpp: "operator<(@)".}
proc `<=`*[K, V](a, b: StdMapIterator[K, V]): bool
  {.importcpp: "operator<=(@)".}

proc `[]`*[K, V](m: StdMap[K, V], k: K): StdPair[K, V]
  {.importcpp: "#[#]".}
proc `[]`*[K, V](m: ptr StdMap[K, V], k: K): ptr StdPair[K, V]
  {.importcpp: "&(*#)[#]".}

proc `[]=`*[K, V](m: var StdMap[K, V], k: K, v: V)
  {.importcpp: "#[#]=#".}

{.pop.}
