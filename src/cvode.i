%module(package="cvode") cvode

#define SUNDIALS_EXPORT

%{
#include "cvode/cvode.h"

static CVRhsFn f_handle = 0;

static int CVodeCallbackToPython(realtype t, N_Vector y, N_Vector ydot, void *user_data)
{
    int i;
    PyObject *arglist = NULL;
    PyObject *result = NULL;
    PyObject *my_callback = (PyObject *)f_handle;
    /* convert regionevent to python object */
    PyObject *obj1 = NULL;
    PyObject *obj2 = NULL;
    PyObject *obj3 = NULL;

    PyObject *double_t = NULL;
    obj1 = SWIG_NewPointerObj(SWIG_as_voidptr(y), SWIGTYPE_p__generic_N_Vector, 0 |  0 );
    obj2 = SWIG_NewPointerObj(SWIG_as_voidptr(ydot), SWIGTYPE_p__generic_N_Vector, 0 |  0 );
    obj3 = (PyObject *)user_data;
    /* Time to call the callback */
    arglist = Py_BuildValue("(d, N, N, O)", t, obj1, obj2, obj3);
    result = PyObject_CallObject(my_callback, arglist);
    Py_DECREF(arglist);
    //Py_DECREF(obj1);
    //Py_DECREF(obj2);
    if (result)
    {
        Py_DECREF(result);
    }

    return 0;
}

int MyCVodeInit(void *cvode_mem, CVRhsFn f, realtype t0, N_Vector y0)
{
  f_handle = f;
  return CVodeInit(cvode_mem, CVodeCallbackToPython, t0, y0);
}

%}

%include "sundials_swig_types.i"

%typemap(in) CVRhsFn {
    $1 = (int (*)(realtype t, N_Vector y, N_Vector ydot, void *user_data))($input);
}

%ignore CVodeInit;
%include "cvode/cvode.h"

%rename(CVodeInit) MyCVodeInit;
int MyCVodeInit(void *cvode_mem, CVRhsFn f, realtype t0, N_Vector y0);
