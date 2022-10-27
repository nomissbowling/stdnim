# stdnimcommon.nim

# import repos
import ../stdnimutils, ../stdvector, ../stdstring
# import strformat

# const reposdir = getReposDir # here
# const extlib = fmt"{reposdir}/ext/lib/libext.lib"
# const extdir = fmt"{reposdir}/ext/include" # extsrc.hpp
# const extsrc = fmt"{reposdir}/ext/src/extsrc.cpp"

{.push stackTrace: off.}
# {.passL: fmt"{extlib}"} # or --passL:.../lib/libext.lib at compile
# {.passC: fmt"-I{extdir}"}
# {.emit: staticRead(extsrc) .}
{.emit: """
#define UNICODE
#define _UNICODE
#include <wchar.h>

#include <iomanip>
#include <iostream>
#include <sstream>
#include <map>
#include <vector>
#include <string>

#include <stdexcept>
#include <exception>

#include <ctime>

using namespace std;

typedef struct {int x; int y;} CPoint;
typedef struct {string txt; vector<CPoint> vec;} CStruct;

int Cfront(vector<CStruct> *pvstruct, string *pstdstr)
{
  if(pstdstr->size() > 0) (*pstdstr)[0] = '!';
  else
    for(int i = 0; i < 2; ++i){
      pvstruct->push_back(CStruct{string("abc"), vector<CPoint>()});
      CStruct &st = pvstruct->at(pvstruct->size() - 1);
      vector<CPoint> &vp = st.vec;
      for(int j = 0; j < 5; ++j) vp.push_back(CPoint{j + i + 1, j + i + 3});
    }
  return 1;
}

int Cback(vector<CStruct> *pvstruct, string *pstdstr)
{
  if(pstdstr->size() > 0) (*pstdstr)[pstdstr->size() - 1] = 'z';
  else
    for(vector<CStruct>::iterator it = pvstruct->begin();
      it != pvstruct->end(); ++it){
      vector<CPoint> &vp = it->vec;
      for(vector<CPoint>::iterator pt = vp.begin(); pt != vp.end(); ++pt)
        pt->x += 10, pt->y -= 1;
    }
  return 0;
}
""".}
{.pop.}

proc cfront(pvstruct: pointer, pstdstr: pointer): cint
  {.importcpp: "Cfront(@)", nodecl.}

proc cback(pvstruct: pointer, pstdstr: pointer): cint
  {.importcpp: "Cback(@)", nodecl.}

proc front*(vstruct: var StdVector[NIMstruct], stdstr: var StdString): int=
  result = cfront(vstruct.addr, stdstr.addr)

proc back*(vstruct: var StdVector[NIMstruct], stdstr: var StdString): int=
  result = cback(vstruct.addr, stdstr.addr)
