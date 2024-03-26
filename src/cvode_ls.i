%module(package="cvode") cvode_ls

#define SUNDIALS_EXPORT

%{
#include "cvode/cvode_ls.h"
%}

%include "sundials_swig_types.i"

%include "cvode/cvode_ls.h"
