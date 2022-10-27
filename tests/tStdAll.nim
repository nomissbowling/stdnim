# tStdAll.nim
#
# nim cpp -d:release -r stdnim/tests/tStdAll

{.push warning[ProveInit]: off .}

import ./std/[tstdvector, tstdstring]

{. pop .}
