%module(package="sundials") sundials_types

#define SUNDIALS_EXPORT

%{

#include "sundials/sundials_types.h"

double SUNDIALS_AsDouble(realtype *r)
{
    return (double)*r;
}

%}

double SUNDIALS_AsDouble(realtype *r);
