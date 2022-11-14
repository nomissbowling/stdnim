# stdstring.nim

import strformat

{.push header: "<string>".}
type
  StdString* {.importcpp: "std::string".} = object
  StdStringIterator* {.importcpp: "std::string::iterator".} = object

proc newStdString*(): StdString
  {.importcpp: "std::string(@)", constructor.}

proc newStdString*(s: cstring): StdString
  {.importcpp: "std::string(@)", constructor.}

proc size*(s: StdString): csize_t {.importcpp: "size".}
# proc size*(s: ptr StdString): csize_t {.importcpp: "#->size()".}
proc cStr*(s: StdString): cstring {.importcpp: "#.c_str()".} # use as $s.cStr
proc cStr*(s: ptr StdString): cstring {.importcpp: "#->c_str()".}
proc clear*(s: var StdString) {.importcpp: "clear".}
proc begin*(s: StdString): StdStringIterator {.importcpp: "begin".}
proc `end`*(s: StdString): StdStringIterator {.importcpp: "end".}
proc `[]`*(it: StdStringIterator): char {.importcpp: "(*#)".}
proc inc*(it: var StdStringIterator) {.importcpp: "(++#)".}
proc next*(it: StdStringIterator; n: clonglong=1): StdStringIterator
  {.importcpp: "next(@)".}
proc `<`*(a, b: StdStringIterator): bool {.importcpp: "operator<(@)".}
proc `<=`*(a, b: StdStringIterator): bool {.importcpp: "operator<=(@)".}
proc at*(s: StdString; idx: clonglong): ptr char {.importcpp: "&#.at(#)".}
proc at*(s: ptr StdString; idx: clonglong): ptr char {.importcpp: "&#->at(#)".}
proc `[]`*(s: StdString; idx: clonglong): char {.importcpp: "#[#]".}
proc `[]`*(s: ptr StdString; idx: clonglong): ptr char {.importcpp: "&(*#)[#]".}
# proc `[]`*(s: var StdString; idx: clonglong): var char {.importcpp: "#[#]".}
proc `[]=`*(s: var StdString; idx: clonglong, c: char) {.importcpp: "#[#]=#".}
{.pop.}

iterator items*(s: StdString): StdStringIterator =
  for it in s.begin..<s.end:
    yield it

iterator pairs*(s: StdString): tuple[key: int, it: StdStringIterator] =
  var i = 0
  for it in s.begin..<s.end:
    yield (i, it)
    i += 1

proc `$`*(s: StdString): string =
  result = $s.cStr

proc `$`*(s: ptr StdString): string =
  result = $s[]

template repr*(s: StdString): string =
  block:
    let s_inj {.inject.} = $s
    fmt"{'\x22'}{s_inj}{'\x22'}"

template repr*(s: ptr StdString): string =
  s[].repr

template len*(s: StdString): int =
  s.size.int
