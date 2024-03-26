%module(package="sunlinsol") sunlinsol_dense

#define SUNDIALS_EXPORT

%{
#include "sunlinsol/sunlinsol_dense.h"
%}

%include "sundials_swig_types.i"

%include "sunlinsol/sunlinsol_dense.h"


