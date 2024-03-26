%module(package="sunmatrix") sunmatrix_dense

#define SUNDIALS_EXPORT

%{
#include "sunmatrix/sunmatrix_dense.h"
%}

%include "sundials_swig_types.i"

%include "sunmatrix/sunmatrix_dense.h"
