add_mlir_dialect_library(MLIRPyTransforms
  InferTypesPass.cpp

  ADDITIONAL_HEADER_DIRS
  ${MLIR_MAIN_INCLUDE_DIR}/mlir/Dialect/Py/Transforms

  DEPENDS
  MLIRPyTransformsIncGen

  LINK_LIBS PUBLIC
  MLIRIR
  MLIRPass
  MLIRPyDialect
  MLIRTransforms
)
