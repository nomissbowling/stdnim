# stdnimutils.nim

import stdpair, stduomap, stdmap, stdvector, stdstring

type
  NIMpoint* = tuple[x: cint, y: cint]

  NIMstruct* = object
    txt*: StdString
    vec*: StdVector[NIMpoint]
    mapo*: StdMap[StdString, NIMpoint]
    mapuo*: StdUoMap[StdString, NIMpoint]
    pairsp*: StdPair[StdString, NIMpoint]
