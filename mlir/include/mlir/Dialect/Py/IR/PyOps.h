//===- PyDialect.h - Pointer dialect ---------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the Py dialect.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_PYOPS_H
#define MLIR_DIALECT_PYOPS_H

#include "mlir/Bytecode/BytecodeOpInterface.h"
#include "mlir/Dialect/Py/IR/PyDialect.h"
#include "mlir/Dialect/Py/IR/PyTypes.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/SymbolTable.h"

#define GET_OP_CLASSES
#include "mlir/Dialect/Py/IR/PyOps.h.inc"

#endif // MLIR_DIALECT_PYOPS_H
