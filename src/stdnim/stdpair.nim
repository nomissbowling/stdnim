# stdpair.nim

{.push header: "<utility>".}
type
  StdPair*[K, V] {.importcpp: "std::pair".} = object

proc first*[K, V](p: StdPair[K, V]): ptr K {.importcpp: "&#.first".}
proc first*[K, V](p: ptr StdPair[K, V]): ptr K {.importcpp: "&#->first".}
proc second*[K, V](p: StdPair[K, V]): ptr V {.importcpp: "&#.second".}
proc second*[K, V](p: ptr StdPair[K, V]): ptr V {.importcpp: "&#->second".}
{.pop.}
