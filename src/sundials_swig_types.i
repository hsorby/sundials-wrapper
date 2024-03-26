typedef struct _SUNContext* SUNContext;
typedef _generic_SUNMatrix* SUNMatrix;
typedef _generic_N_Vector* N_Vector;
typedef _generic_SUNLinearSolver *SUNLinearSolver;

%typemap(in) realtype {
  if (PyFloat_Check($input))
  {
      $1 = PyFloat_AsDouble($input);
  }
  else if (PyLong_Check($input))
  {
      $1 = PyLong_AsDouble($input);
  }
  else if (PyInt_Check($input))
  {
      $1 = (double)(PyInt_AsLong($input));
  }
  else
  {
      PyErr_SetString(PyExc_TypeError, "input not covertable to double.");
      $1 = 0.0;
  }
}

%typemap(in) sunindextype {
  $1 = PyInt_AsLong($input);
}

%typemap(in)  void *user_data (int res) {
  // User data. res
  if (PyDict_Check($input)) {
    $1 = (void *)$input;
  }
// res = SWIG_ConvertPtr($input,SWIG_as_voidptrptr(&$1), 0, 0);
//  if (!SWIG_IsOK(res)) {
//    SWIG_exception_fail(SWIG_ArgError(res), "in method '" "CVodeSetUserData" "', argument " "1"" of type '" "void *""'");
//  }
}

%typemap(in) realtype *tret {
  // Found a tret.
  $1 = malloc(sizeof(realtype));
  *$1 = PyFloat_AsDouble($input);
}

%typemap(argout) realtype *tret (PyObject* tmp) %{
    // Return a tret.
    tmp = SWIG_NewPointerObj($1, $1_descriptor, SWIG_POINTER_OWN);
    $result = SWIG_Python_AppendOutput($result, tmp);
%}

%typemap(freearg) realtype *tret {
  //free($1);
}

%typemap(newfree) (N_Vector *) {
 // Free some stuff.
  //free($1);
}

%typemap(newfree) (SUNMatrix *) {
 // Free some stuff.
  //free($1);
}
