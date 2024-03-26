%module(package="sundials") sundials_matrix

#define SUNDIALS_EXPORT
#define _SUNDIALS_STRUCT_

%{
#include "sundials/sundials_matrix.h"
%}

%include "sundials/sundials_matrix.h"
