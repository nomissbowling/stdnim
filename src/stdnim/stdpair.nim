# stdpair.nim

import strformat

{.push header: "<utility>".}
type
  StdPair*[K, V] {.importcpp: "std::pair".} = object

proc first*[K, V](p: StdPair[K, V]): ptr K {.importcpp: "&#.first".}
proc first*[K, V](p: ptr StdPair[K, V]): ptr K {.importcpp: "&#->first".}
proc second*[K, V](p: StdPair[K, V]): ptr V {.importcpp: "&#.second".}
proc second*[K, V](p: ptr StdPair[K, V]): ptr V {.importcpp: "&#->second".}
{.pop.}

proc `$`*[K, V](p: StdPair[K, V]): string =
  result = fmt"<{p.first[].repr}: {p.second[].repr}>"

proc `$`*[K, V](p: ptr StdPair[K, V]): string =
  result = $p[]

template repr*[K, V](p: StdPair[K, V]): string =
  $p

template repr*[K, V](p: ptr StdPair[K, V]): string =
  p[].repr
