
import cpp

class NetworkByteSwap extends Expr {
  NetworkByteSwap () {
    // TODO: replace <class> and <var>
    exists(MacroInvocation mc | mc.getMacro().getName().regexpMatch("ntoh.") and this = mc.getExpr() 
      // TODO: <condition>
    )
  }
}

from NetworkByteSwap n
select n, "Network byte swap"