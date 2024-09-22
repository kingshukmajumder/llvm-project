//===- PtrOps.td - Pointer dialect ops ---------------------*- tablegen -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://ptr.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef PY_OPS
#define PY_OPS

include "mlir/Dialect/Py/IR/PyDialect.td"
include "mlir/IR/OpAsmInterface.td"
include "mlir/IR/EnumAttr.td"
include "mlir/IR/SymbolInterfaces.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

def PyActorOp : Op<Py_Dialect, "actor", 
    [NoRegionArguments, SymbolTable]> {
  let summary = "Python actor";
  let description = [{
    The `py.actor` operation represents a python actor.

    Example:
    ```mlir
    py.actor {
        func.func(...){
            ...
        }
    }
    ```
  }];
  let arguments = (ins SymbolNameAttr:$sym_name);
  let regions = (region SizedRegion<1>:$region);
  let assemblyFormat=[{ $sym_name $region attr-dict}];
}

def PyForOp : Op<Py_Dialect, "for", 
    [SingleBlockImplicitTerminator<"py::PyYieldOp">]> {
  let summary = "For loop";
  let description = [{
    The `py.for` operation represents a python for loop.

    Example:

    ```mlir
    py.for %i in %range{
        ...
    }
    ```
  }];

    
  let arguments = (ins Py_AnyType:$range);
  let regions = (region SizedRegion<1>:$region);
  let hasCustomAssemblyFormat = 1;
}

def PyIfOp : Op<Py_Dialect, "if", 
    [NoRegionArguments]> {
  let summary = "Python if-else";
  let description = [{
    The `py.if` operation represents an if-else operation.

    Example:
    ```mlir
       py.if (%x:py.any<i1>) {
       }else{
       } 
    }
    ```
  }];

    
  let arguments = (ins Py_AnyType:$cond);
  let regions = (region SizedRegion<1>:$ifregion, VariadicRegion<SizedRegion<1>>:$elseregion);
  let assemblyFormat=[{ `(`$cond `:` type($cond)`)` $ifregion (`else` $elseregion^)? attr-dict}];
}

def PyConstantOp : Op<Py_Dialect, "const", []> {
  let summary = "Constant";
  let description = [{
    The `py.const` operation represents a constant value.

    Example:

    ```mlir
    %i = py.const [3] : !py.any<i32>
    %a = py.const [1, 2, 3, 4] : !py.any<tensor<2 x 2 x i32>>
    ```
  }];
  let arguments = (ins ArrayAttr: $value);
  let results =  (outs Py_AnyType:$result);
  let assemblyFormat = [{$value attr-dict `:` type($result)}];
}

def PyYieldOp : Op<Py_Dialect,"yield", [Terminator]> {
  let summary = "loop yield and termination operation";
  let description = [{
    The `py.yield` terminates the loop.
  }];

  let assemblyFormat = [{  attr-dict }];
}

def PyAllocaOp : Op<Py_Dialect,"alloca", []> {
  let summary = "Allocate on stack";
  let description = [{
    The `py.alloca` op allocates a variable on the stack.

    ```mlir
    %i = py.alloca "varname" : py_any
    ```
  }];

  let arguments = (ins StrAttr:$name);
  let results =  (outs Py_AnyType:$result);
  let assemblyFormat = [{  $name attr-dict `:` type($result) }];
}

def PyLoadOp : Op<Py_Dialect,"load", []> {
  let summary = "Load from memory location";
  let description = [{
    The `py.load` op loads value from a location.

    ```mlir
    %x= py.load %mem  : !py.any, !py.any
    ```
  }];

  let arguments = (ins Py_AnyType: $mem, Variadic<Index>:$addr);
  let results =  (outs Py_AnyType:$result);
  let assemblyFormat = [{  $mem (`[` $addr^ `]`)? attr-dict `:` type($result) `,` type($mem) }];
}

def PyStoreOp : Op<Py_Dialect,"store", []> {
  let summary = "Store to memory location";
  let description = [{
    The `py.store` op stores value to a location.

    ```mlir
    py.store %value, %mem  : !py.any, !py.any
    ```
  }];

  let arguments = (ins Py_AnyType:$value, Py_AnyType: $mem, Variadic<Index>:$addr);
  let assemblyFormat = [{  $value `,` $mem (`[` $addr^ `]`)? attr-dict `:` type($value) `,` type($mem) }];

}

def PyGlobalOp : Op<Py_Dialect,"global",[]>{
  let summary = "Python global variable.";
  let arguments = (ins StrAttr:$name);
  let results = (outs Py_AnyType:$result);
  let assemblyFormat = [{$name attr-dict `:` type($result)}];
}

def PyCallOp : Op<Py_Dialect,"call", []> {
  let summary = "Call a python function.";
  let description = [{
    The `py.call` op calls a python function/closure.

    ```mlir
    %x = py.call %name(%arg0, %arg1):(!py.any, !py.any) -> (!py.any)
    ```
  }];

  let arguments = (ins Py_AnyType:$callee, Variadic<Py_AnyType>:$args);
  let results = (outs Py_AnyType:$result);
  let assemblyFormat = [{  $callee `(` $args `)` attr-dict `:` type($callee) `,` type($args) `->` type($result) }];
}

def PyGetAttrOp: Op<Py_Dialect, "get_attr",[]>{
  let summary = "Call a python function.";
  let arguments = (ins Py_AnyType:$input, StrAttr:$attr);
  let results = (outs Py_AnyType:$result);
  let assemblyFormat = [{$input `,` $attr attr-dict `:` type($input) `->` type($result)}];
}

def PyTypeConstraintOp: Op<Py_Dialect, "type_constraint",[]>{
  let summary = "Add a type constraint to a variable of allocaop.";
  let arguments = (ins Py_AnyType:$input, TypeAttr:$type_constraint);
  let assemblyFormat = [{$input attr-dict `:` type($input) `->` $type_constraint}];
}
#endif // PY_OPS
