//===- PtrOps.td - Pointer dialect ops ---------------------*- tablegen -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://ptr.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef PY_TYPES
#define PY_TYPES

include "mlir/Dialect/Py/IR/PyDialect.td"
include "mlir/IR/AttrTypeBase.td"
include "mlir/IR/BuiltinTypeInterfaces.td"

def Py_AnyType
    : TypeDef<Py_Dialect, "Any", []> {
  let mnemonic = "any";
let summary = "python any type";
  let description = [{
    The `PyObject` type specifies an unknown python datatype.

    Syntax:

    ```mlir
    py.any
    ```
  }];

  let parameters = (ins OptionalParameter<"TypeAttr">:$inferred_type);
  let assemblyFormat = "(`<` $inferred_type^ `>`)?";
}

#endif // PY_OPS
