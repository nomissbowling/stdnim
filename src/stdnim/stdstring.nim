# stdstring.nim

{.push header: "<string>".}
type
  StdString* {.importcpp: "std::string".} = object

proc newStdString*(): StdString
  {.importcpp: "std::string(@)", constructor.}

proc newStdString*(s: cstring): StdString
  {.importcpp: "std::string(@)", constructor.}

proc size*(s: StdString): csize_t {.importcpp: "size".}
proc cStr*(s: StdString): cstring {.importcpp: "#.c_str()".} # use as $s.cStr
proc at*(s: StdString, idx: clong): ref char {.importcpp: "&#.at(#)".}
proc at*(s: ref StdString, idx: clong): ref char {.importcpp: "&#->at(#)".}
proc `[]`*(s: StdString, idx: clong): char {.importcpp: "#[#]".}
proc `[]`*(s: ref StdString, idx: clong): ref char {.importcpp: "&(*#)[#]".}
# proc `[]`*(s: var StdString, idx: clong): var char {.importcpp: "#[#]".}
proc `[]=`*(s: var StdString, idx: clong, c: char) {.importcpp: "#[#]=#".}
{.pop.}
