# stdnimutils.nim

import stdvector, stdstring

type
  NIMpoint* = tuple[x: cint, y: cint]

type
  NIMstruct* = object
    txt*: StdString
    vec*: StdVector[NIMpoint]
