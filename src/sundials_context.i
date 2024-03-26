%module(package="sundials") sundials_context

%include "typemaps.i"

#define SUNDIALS_EXPORT

%{
#include "sundials/sundials_context.h"

SUNContext My_SUNContext_Create(void *comm)
{
    SUNContext *ctx = malloc(sizeof(SUNContext *)) ;
    SUNContext_Create(comm, ctx);
    return *ctx;
}

SUNContext *SUNContext_Define()
{
//    SUNContext ctx;
    return malloc(sizeof(SUNContext *));
}

SUNContext SUNContext_Context(SUNContext *ctx)
{
    return *ctx;
}

%}

//%ignore SUNContext_Create;

%include "sundials/sundials_context.h"
//%rename(SUNContext_Create) My_SUNContext_Create;
//SUNContext My_SUNContext_Create(void *comm);
SUNContext *SUNContext_Define();
SUNContext SUNContext_Context(SUNContext *ctx);
