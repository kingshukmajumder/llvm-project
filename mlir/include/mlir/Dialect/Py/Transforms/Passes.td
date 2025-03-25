//===-- Passes.td - NvGpu pass definition file ------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_PYDIALECT_TRANSFORMS_TD
#define MLIR_PYDIALECT_TRANSFORMS_TD

include "mlir/Pass/PassBase.td"

def InferTypes : Pass<"py-infer-types", "ModuleOp"> {
  let summary = "Performs type inference on Py dialect.";
  let constructor = "mlir::py::createInferTypesPass()";
  let dependentDialects = [
    "py::PyDialect"
  ];
}

#endif // MLIR_PYDIALECT_TRANSFORMS_TD
