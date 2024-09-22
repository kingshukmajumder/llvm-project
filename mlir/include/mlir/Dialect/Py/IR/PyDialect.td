//===- PtrDialect.td - Pointer dialect ---------------------*- tablegen -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef PY_DIALECT
#define PY_DIALECT

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// Pointer dialect definition.
//===----------------------------------------------------------------------===//

def Py_Dialect : Dialect {
  let name = "py";
  let summary = "Python dialect";
  let cppNamespace = "::mlir::py";
  let useDefaultTypePrinterParser = 1;
}


include "mlir/Dialect/Py/IR/PyTypes.td"


#endif // PTR_DIALECT
