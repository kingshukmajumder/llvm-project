set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name Py)
add_public_tablegen_target(MLIRPyTransformsIncGen)

add_mlir_doc(Passes PyPasses ./ -gen-pass-doc)
