

cmake_minimum_required(VERSION 3.18.0)

set(CMAKE_OSX_DEPLOYMENT_TARGET 12 CACHE STRING "Minimum OS X deployment version.")

project(SUNDIALS-Wrapper VERSION 0.1.0 LANGUAGES CXX C)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  set(_FIND_PYTHON_DEVELOPMENT_TYPE Development.Module)
  set(FIND_PYTHON_DEVELOPMENT_MODULE TRUE)
else()
  set(_FIND_PYTHON_DEVELOPMENT_TYPE Development)
endif()

find_package(Python 3 COMPONENTS Interpreter ${_FIND_PYTHON_DEVELOPMENT_TYPE})
find_package(SWIG 3)
find_package(SUNDIALS REQUIRED cvode kinsol)

include(${SWIG_USE_FILE})

if(SWIG_EXECUTABLE AND (Python_Development.Module_FOUND OR Python_Development_FOUND))
  add_subdirectory(src)
endif()
