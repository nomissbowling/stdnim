# tAll.nim
#
# nim cpp -d:release -r stdnim/tests/tAll

{.push warning[ProveInit]: off .}

import tests/std/[tstdvector, tstdstring]

{. pop .}
