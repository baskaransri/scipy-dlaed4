#cython: language_level=3
cimport numpy as cnp
cimport scipy.linalg.cython_lapack as cython_lapack

ctypedef cnp.float64_t REAL_t

#Inputs: N = len(D) = len(Z) :: Int, I :: Int, D :: [Double], Z :: [Double], Rho :: Double
#Outputs: Delta :: [Double] (ordered), DLAM :: Double, INFO :: Int
#Assumes D is sorted!
cpdef REAL_t dlaed4( n, i, D, Z, rho, Delta_out):
    cdef int N = n
    cdef int I = i
    cdef REAL_t RHO = rho
    cdef REAL_t* D_pointer = <REAL_t *>cnp.PyArray_DATA(D)
    cdef REAL_t* Z_pointer = <REAL_t *>cnp.PyArray_DATA(Z)
    cdef REAL_t* Delta_out_pointer = <REAL_t *>cnp.PyArray_DATA(Delta_out)

    cdef REAL_t OUT
    cdef int INFO_OUT

    cython_lapack.dlaed4(&N,&I,D_pointer,Z_pointer,Delta_out_pointer, &RHO, &OUT, &INFO_OUT)
    #print(INFO_OUT)
    return OUT

cpdef (REAL_t, int) dlaed4_ex( n, i, D, Z, rho, Delta_out):
    cdef int N = n
    cdef int I = i
    cdef REAL_t RHO = rho
    cdef REAL_t* D_pointer = <REAL_t *>cnp.PyArray_DATA(D)
    cdef REAL_t* Z_pointer = <REAL_t *>cnp.PyArray_DATA(Z)
    cdef REAL_t* Delta_out_pointer = <REAL_t *>cnp.PyArray_DATA(Delta_out)

    cdef REAL_t OUT
    cdef int INFO_OUT

    cython_lapack.dlaed4(&N,&I,D_pointer,Z_pointer,Delta_out_pointer, &RHO, &OUT, &INFO_OUT)
    return (OUT,INFO_OUT)
