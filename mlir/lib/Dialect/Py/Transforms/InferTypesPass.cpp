#include "mlir/Dialect/Py/IR/PyDialect.h"
#include "mlir/Dialect/Py/Transforms/Passes.h"

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

  void runOnOperation() override { Operation *op = getOperation(); }
};
} // namespace

std::unique_ptr<Pass> mlir::py::createInferTypesPass() {
  return std::make_unique<InferTypesPass>();
}