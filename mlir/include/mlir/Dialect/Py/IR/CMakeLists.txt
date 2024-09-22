add_mlir_dialect(PyOps py)
add_mlir_doc(PyOps PyOps Dialects/ -gen-dialect-doc -dialect=py)

set(LLVM_TARGET_DEFINITIONS PyOps.td)
