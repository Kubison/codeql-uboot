
import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph


class NetworkByteSwap extends Expr {
    NetworkByteSwap () {
      // TODO: replace <class> and <var>
      exists(MacroInvocation mc | mc.getMacro().getName().regexpMatch("ntoh.") and this = mc.getExpr() 
        // TODO: <condition>
      )
    }
  }



class Config extends TaintTracking::Configuration {
    Config() { this = "Config: this name doesn't matter" }
  
    override predicate isSource(DataFlow::Node source) { source.asExpr() instanceof NetworkByteSwap }
  
    override predicate isSink(DataFlow::Node sink) {
      exists(FunctionCall c | c.getTarget().getName() = "memcpy" and sink.asExpr() = c.getArgument(2))
    }
  }
  
  from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
  where cfg.hasFlowPath(source, sink)
  select sink, source, sink, "Network byte swap flows to memcpy"
  