#include "mlir/Dialect/Py/IR/PyOps.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Transforms/InliningUtils.h"
#include "llvm/ADT/SmallString.h"
#include "llvm/ADT/TypeSwitch.h"

using namespace mlir;
using namespace mlir::py;

//===----------------------------------------------------------------------===//
// Py dialect
//===----------------------------------------------------------------------===//

void PyDialect::initialize() {
  addOperations<
#define GET_OP_LIST
#include "mlir/Dialect/Py/IR/PyOps.cpp.inc"
      >();
  
  addTypes<
#define GET_TYPEDEF_LIST
#include "mlir/Dialect/Py/IR/PyOpsTypes.cpp.inc"
      >();
}

//===----------------------------------------------------------------------===//
// Py API.
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/Py/IR/PyOpsDialect.cpp.inc"

#define GET_TYPEDEF_CLASSES
#include "mlir/Dialect/Py/IR/PyOpsTypes.cpp.inc"

#define GET_OP_CLASSES
#include "mlir/Dialect/Py/IR/PyOps.cpp.inc"
