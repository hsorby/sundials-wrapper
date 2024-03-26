%module(package="nvector") nvector_serial

#define SUNDIALS_EXPORT
#define SUNDIALS_DEPRECATED_EXPORT

%{
#include "sundials/sundials_types.h"
#include "nvector/nvector_serial.h"
%}

%include "sundials_swig_types.i"

%typemap(in) (realtype *) {
  // Again $symname.
if (PyList_Check($input))
    {
        int size = PyList_Size($input);
        $1 = malloc(sizeof(double)*size);
        for (int i = 0; i < size; i++)
        {
            PyObject *o = PyList_GetItem($input,i);
            if (PyFloat_Check(o))
            {
                $1[i] = PyFloat_AsDouble(o);
            }
            else if (PyLong_Check(o))
            {
                $1[i] = PyLong_AsDouble(o);
            }
            else if (PyInt_Check(o))
            {
                $1[i] = (double)(PyInt_AsLong(o));
            }
            else
            {
                PyErr_SetString(PyExc_TypeError, "list may only contain numbers.");
                free($1);
                return NULL;
            }
        }
    }
    else
    {
        PyErr_SetString(PyExc_TypeError, "not a list.");
        return NULL;
    }
}

%include "nvector/nvector_serial.h"

%typemap(out) (realtype *)
{
    // Convert to Python list???
    sunindextype i;
    sunindextype size = N_VGetLength_Serial(arg1);
    $result = PyList_New(size);
    //obj2 = PyList_New(state_count);
    for (i = 0; i < size; i++) {
        PyObject *o = PyFloat_FromDouble((double) $1[i]);
        PyList_SetItem($result, i, o);
    //    o = PyFloat_FromDouble((double) N_VGetArrayPointer(ydot)[i]);
    //    PyList_SetItem(obj2, i, o);
    }
};

%{

realtype *N_VConvertArray_Serial(N_Vector v)
{
    return N_VGetArrayPointer_Serial(v);
}

void N_VUpdate_Serial(N_Vector v, realtype *in)
{
    sunindextype i, size = N_VGetLength_Serial(v);
    realtype *v_data = N_VGetArrayPointer_Serial(v);

    for (i = 0; i < size; i++) {
        v_data[i] = in[i];
    }
}

%}

realtype *N_VConvertArray_Serial(N_Vector v);
void N_VUpdate_Serial(N_Vector v, realtype *);
