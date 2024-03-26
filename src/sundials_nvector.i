%module(package="sundials") sundials_nvector

#define SUNDIALS_EXPORT
#define _SUNDIALS_STRUCT_

%{
#include "sundials/sundials_nvector.h"
%}

%include "sundials_swig_types.i"

%include "sundials/sundials_nvector.h"
