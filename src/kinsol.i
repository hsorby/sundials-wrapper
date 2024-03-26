%module(package="kinsol") kinsol

%include "typemaps.i"

#define SUNDIALS_EXPORT
#define SUNDIALS_DEPRECATED_EXPORT_MSG(x)

%{
#include "kinsol/kinsol.h"

static KINSysFn f_handle = 0;
//typedef int (*KINSysFn)(N_Vector uu, N_Vector fval, void *user_data);

static int KinsolCallbackToPython(N_Vector uu, N_Vector fval, void *user_data)
{
    PyObject *arglist = NULL;
    PyObject *result = NULL;
    PyObject *my_callback = (PyObject *)f_handle;
    PyObject *obj1 = NULL;
    PyObject *obj2 = NULL;
    PyObject *obj3 = NULL;

    obj1 = SWIG_NewPointerObj(SWIG_as_voidptr(uu), SWIGTYPE_p__generic_N_Vector, 0 |  0 );
    obj2 = SWIG_NewPointerObj(SWIG_as_voidptr(fval), SWIGTYPE_p__generic_N_Vector, 0 |  0 );
    obj3 = (PyObject *)user_data;
    /* Time to call the callback */
    arglist = Py_BuildValue("(N, N, O)", obj1, obj2, obj3);
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

int MyKINInit(void *cvode_mem, KINSysFn f, N_Vector y0)
{
  f_handle = f;
  return KINInit(cvode_mem, KinsolCallbackToPython, y0);
}

%}

%include "sundials_swig_types.i"

%typemap(in) KINSysFn {
    $1 = (int (*)(N_Vector uu, N_Vector fval, void *user_data))($input);
}

%ignore KINInit;

%include "kinsol/kinsol.h"

%rename(KINInit) MyKINInit;
int MyKINInit(void *cvode_mem, KINSysFn f, N_Vector y0);
