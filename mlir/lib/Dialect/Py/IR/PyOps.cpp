#include "mlir/Dialect/Py/IR/PyOps.h"
#include "mlir/Dialect/Py/IR/PyTypes.h"
#include "mlir/IR/IRMapping.h"
#include "mlir/IR/IntegerSet.h"
#include "mlir/IR/Matchers.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Interfaces/ShapedOpInterfaces.h"
#include "mlir/Interfaces/ValueBoundsOpInterface.h"
#include "mlir/Transforms/InliningUtils.h"
#include "llvm/ADT/ScopeExit.h"
#include "llvm/ADT/SmallBitVector.h"
#include "llvm/ADT/SmallVectorExtras.h"
#include "llvm/ADT/TypeSwitch.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/MathExtras.h"
#include <numeric>
#include <optional>

using namespace mlir;

ParseResult py::PyForOp::parse(OpAsmParser &parser, OperationState &result) {
  auto &builder = parser.getBuilder();
  OpAsmParser::Argument iv;
  OpAsmParser::UnresolvedOperand range;
  Type ivTy = py::AnyType::get(builder.getContext(), TypeAttr());
  Type rangeTy = py::AnyType::get(builder.getContext(), TypeAttr());

  // Parse the induction variable followed by '='.
  if (parser.parseArgument(iv) || parser.parseKeyword("in") ||
      parser.parseOperand(range))
    return failure();

  iv.type = ivTy;
  if (parser.resolveOperand(range, rangeTy, result.operands)) {
    return failure();
  }

  // Parse the body region.
  Region *body = result.addRegion();
  if (parser.parseRegion(*body, {iv}))
    return failure();
  PyForOp::ensureTerminator(*body, builder, result.location);

  // Parse the optional attribute list.
  return parser.parseOptionalAttrDict(result.attributes);
}

void py::PyForOp::print(OpAsmPrinter &p) {
  p << ' ';
  p.printRegionArgument(this->getRegion().getBlocks().front().getArgument(0),
                        /*argAttrs=*/{},
                        /*omitType=*/true);
  p << " in ";
  p << this->getRange();
  p.printRegion(this->getRegion(), false, false);

  p.printOptionalAttrDict((*this)->getAttrs(),
                          /*elidedAttrs=*/{});
}