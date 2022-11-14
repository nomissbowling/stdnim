# stdvector.nim

{.push header: "<vector>".}
type
  StdVector*[T] {.importcpp: "std::vector".} = object
  StdVectorIterator*[T] {.importcpp: "std::vector<'0>::iterator".} = object

proc newStdVector*[T](): StdVector[T]
  {.importcpp: "std::vector<'*0>(@)", constructor.}

proc size*[T](v: StdVector[T]): csize_t {.importcpp: "size".}
# proc size*[T](v: ptr StdVector[T]): csize_t {.importcpp: "#->size()".}
proc pushBack*[T](v: var StdVector[T]; x: T) {.importcpp: "push_back".}
proc popBack*[T](v: var StdVector[T]) {.importcpp: "pop_back".}
proc clear*[T](v: var StdVector[T]) {.importcpp: "clear".}
proc begin*[T](v: StdVector[T]): StdVectorIterator[T] {.importcpp: "begin".}
proc `end`*[T](v: StdVector[T]): StdVectorIterator[T] {.importcpp: "end".}
proc `[]`*[T](it: StdVectorIterator[T]): T {.importcpp: "(*#)".}
proc inc*[T](it: var StdVectorIterator[T]) {.importcpp: "(++#)".}
proc next*[T](it: StdVectorIterator[T]; n: clonglong=1): StdVectorIterator[T]
  {.importcpp: "next(@)".}
proc `<`*[T](a, b: StdVectorIterator[T]): bool {.importcpp: "operator<(@)".}
proc `<=`*[T](a, b: StdVectorIterator[T]): bool {.importcpp: "operator<=(@)".}
proc at*[T](v: StdVector[T], idx: clonglong): ptr T {.importcpp: "&#.at(#)".}
proc at*[T](v: ptr StdVector[T], idx: clonglong): ptr T {.importcpp: "&#->at(#)".}
proc `[]`*[T](v: StdVector[T], idx: clonglong): T {.importcpp: "#[#]".}
proc `[]`*[T](v: ptr StdVector[T], idx: clonglong): ptr T {.importcpp: "&(*#)[#]".}
# proc `[]`*[T](v: var StdVector[T], idx: clonglong): var T {.importcpp: "#[#]".}
proc `[]=`*[T](v: var StdVector[T], idx: clonglong, e: T) {.importcpp: "#[#]=#".}
{.pop.}

iterator items*[T](v: StdVector[T]): StdVectorIterator[T] =
  for it in v.begin..<v.end:
    yield it

iterator pairs*[T](v: StdVector[T]): tuple[key: int, it: StdVectorIterator[T]] =
  var i = 0
  for it in v.begin..<v.end:
    yield (i, it)
    i += 1

proc `$`*[T](it: StdVectorIterator[T]): string =
  result = $it[]

proc repr*[T](it: StdVectorIterator[T]): string =
  result = $it[]
