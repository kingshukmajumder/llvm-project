// RUN: mlir-opt %s -split-input-file | mlir-opt | FileCheck %s

py.actor @test_actor {
    func.func @method(){
        return
    }
    py.yield
}

// CHECK-LABEL: func @test_loop
func.func @test_loop(%arg0: !py.any) {
 %x = py.const [1] :!py.any<i32>
 %range = py.const [1,2,3,4] :!py.any
 py.for %i in %range{
 }
  return
}

func.func @test_if() {
 %b = py.const [1] :!py.any<i1>
 py.if (%b:!py.any<i1>){
    py.yield
 }
  return
}

func.func @test_else() {
 %b = py.const [1] :!py.any<i1>
 py.if (%b:!py.any<i1>){
    py.yield
 }else{
    py.yield
 }
  return
}