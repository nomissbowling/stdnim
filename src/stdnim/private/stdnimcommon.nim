# stdnimcommon.nim

# import repos
import ../stdnimutils
import ../stdpair, ../stduomap, ../stdmap
import ../stdvector, ../stdstring
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
#include <utility>
#include <unordered_map>
#include <map>
#include <vector>
#include <string>

#include <stdexcept>
#include <exception>

#include <ctime>

using namespace std;

typedef struct {int x; int y;} CPoint;
typedef struct {
  string txt;
  vector<CPoint> vec;
  map<string, CPoint> mapo;
  unordered_map<string, CPoint> mapuo;
  pair<string, CPoint> pairsp;
} CStruct;

int Cfront(vector<CStruct> *pvstruct, string *pstdstr)
{
  if(pstdstr->size() > 0 && (*pstdstr)[0] != '*')
    (*pstdstr)[0] = '!';
  else
    for(int i = 0; i < 2; ++i){
      pvstruct->push_back(CStruct{
        string("abc"),
        vector<CPoint>(),
        map<string, CPoint>(),
        unordered_map<string, CPoint>(),
        pair<string, CPoint>()});
      CStruct &st = pvstruct->at(pvstruct->size() - 1);

      string &s = st.txt;
      s[1] = 'B';

      if(*pstdstr == "*StdVector"){
        vector<CPoint> &vp = st.vec;
        for(int j = 0; j < 5; ++j) vp.push_back(CPoint{j + i + 1, j + i + 3});
      }

      if(*pstdstr == "*StdMap"){
        int j = (i + 1) * 100;
        map<string, CPoint> &mo = st.mapo;
        mo["D"] = CPoint{j, j + 3};
        mo["alpha"] = CPoint{j + 3, 7};
        mo["Beta"] = CPoint{j + 5, 1};
        mo["ccc"] = CPoint{j + 3, 3};
      }

      if(*pstdstr == "*StdUoMap"){
        int j = (i + 1) * 1000;
        unordered_map<string, CPoint> &mu = st.mapuo;
        mu["D"] = CPoint{j, j + 33};
        mu["alpha"] = CPoint{j + 33, 77};
        mu["Beta"] = CPoint{j + 55, 11};
        mu["ccc"] = CPoint{j + 33, 33};
      }

      if(*pstdstr == "*StdPair"){
        pair<string, CPoint> &sp = st.pairsp;
        sp.first = string("test key");
        sp.second = CPoint{(i + 1) * 2, (i + 1) * 3};
      }
    }
  return 1;
}

int Cback(vector<CStruct> *pvstruct, string *pstdstr)
{
  if(pstdstr->size() > 0 && (*pstdstr)[0] != '*')
    (*pstdstr)[pstdstr->size() - 1] = 'z';
  else
    for(vector<CStruct>::iterator it = pvstruct->begin();
      it != pvstruct->end(); ++it){
      string &s = it->txt;
      s[0] = 'Z';

      if(*pstdstr == "*StdVector"){
        vector<CPoint> &vp = it->vec;
        for(vector<CPoint>::iterator pt = vp.begin(); pt != vp.end(); ++pt)
          pt->x += 10, pt->y -= 1;
      }

      if(*pstdstr == "*StdMap"){
        map<string, CPoint> &mo = it->mapo;
        for(map<string, CPoint>::iterator mt = mo.begin();
          mt != mo.end(); ++mt){
          CPoint &p = mt->second;
          // cout << "mo[" << mt->first << "] " << p.x << ", " << p.y << endl;
        }
      }

      if(*pstdstr == "*StdUoMap"){
        unordered_map<string, CPoint> &mu = it->mapuo;
        for(unordered_map<string, CPoint>::iterator mt = mu.begin();
          mt != mu.end(); ++mt){
          CPoint &p = mt->second;
          // cout << "mu[" << mt->first << "] " << p.x << ", " << p.y << endl;
        }
      }

      if(*pstdstr == "*StdPair"){
        pair<string, CPoint> &sp = it->pairsp;
        sp.first += " abc";
        sp.second.x += 100, sp.second.y += 300;
      }
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
