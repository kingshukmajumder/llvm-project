add_mlir_dialect_library(
  MLIRPyDialect
  PyTypes.cpp
  PyOps.cpp
  PyDialect.cpp

  DEPENDS
  MLIRPyOpsIncGen

  LINK_LIBS
  PUBLIC
  MLIRIR
)
