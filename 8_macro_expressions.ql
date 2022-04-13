

import cpp
from MacroInvocation mcr
where mcr.getMacro().getName().regexpMatch("ntoh.")
select mcr.getExpr()
