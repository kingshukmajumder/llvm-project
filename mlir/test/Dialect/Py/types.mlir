// RUN: mlir-opt %s -split-input-file | mlir-opt | FileCheck %s


// CHECK-LABEL: func @test_simple
// CHECK: %[[ARG:.*]]: !py.any
func.func @test_simple(%arg0: !py.any) {
  return
}

// CHECK-LABEL: func @test_inferred
// CHECK: %[[ARG:.*]]: !py.any<memref<3x3xf32>>
func.func @test_inferred(%arg0: !py.any<memref<3x3xf32>>) {
  return
}