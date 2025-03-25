#include "mlir-c/Support.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Py/IR/PyDialect.h"
#include "mlir/Dialect/Py/IR/PyOps.h"
#include "mlir/Dialect/Py/Transforms/Passes.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/Visitors.h"

// using namespace mlir;
namespace mlir {
namespace py {
#define GEN_PASS_DEF_INFERTYPES
#include "mlir/Dialect/Py/Transforms/Passes.h.inc"
} // namespace py
} // namespace mlir
using namespace mlir;
using namespace mlir::py;

namespace {
class InferTypesPass : public mlir::py::impl::InferTypesBase<InferTypesPass> {

public:
  InferTypesPass() = default;
  void runOnOperation() override {
    Operation *op = getOperation();
    op->walk([this](Operation *operation) {
      if (auto op = dyn_cast<py::PyActorOp>(operation)) {
        if (failed(this->visit(op)))
          return WalkResult::interrupt();
      } else if (auto op = dyn_cast<func::FuncOp>(operation)) {
        if (failed(this->visit(op)))
          return WalkResult::interrupt();
      }
      return WalkResult::advance();
    });
  }

private:
  LogicalResult visit(py::PyActorOp op) { return success(); }
  LogicalResult visit(func::FuncOp op) { return success(); }
};
} // namespace

std::unique_ptr<Pass> mlir::py::createInferTypesPass() {
  return std::make_unique<InferTypesPass>();
}