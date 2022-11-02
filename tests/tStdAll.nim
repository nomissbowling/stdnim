# tStdAll.nim
#
# nim cpp -d:release -r stdnim/tests/tStdAll

{.push warning[ProveInit]: off .}

import ./std/[tstdpair, tstduomap, tstdmap, tstdvector, tstdstring]

{. pop .}
