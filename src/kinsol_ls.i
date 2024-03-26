%module(package="kinsol") kinsol_ls

#define SUNDIALS_EXPORT

%{
#include "kinsol/kinsol_ls.h"
%}

%include "sundials_swig_types.i"

%include "kinsol/kinsol_ls.h"
