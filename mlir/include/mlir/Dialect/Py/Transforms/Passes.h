//===- Passes.h - Py pass entry points -----------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This header file defines prototypes that expose pass constructors.
//
//===----------------------------------------------------------------------===//
#ifndef MLIR_PYDIALECT_TRANSFORMS_H
#define MLIR_PYDIALECT_TRANSFORMS_H

#include "mlir/Pass/Pass.h"

namespace mlir {
namespace py {

#define GEN_PASS_DECL
#include "mlir/Dialect/Py/Transforms/Passes.h.inc"

/// Create a pass to optimize shared memory reads and writes.
std::unique_ptr<Pass> createInferTypesPass();

} // namespace py

//===----------------------------------------------------------------------===//
// Registration
//===----------------------------------------------------------------------===//

/// Generate the code for registering passes.
#define GEN_PASS_REGISTRATION
#include "mlir/Dialect/Py/Transforms/Passes.h.inc"

} // namespace mlir

#endif // MLIR_PYDIALECT_TRANSFORMS_H
