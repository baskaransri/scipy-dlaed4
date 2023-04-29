#!/usr/bin/env python3
import numpy as np
import scipy_dlaed4.scipy_dlaed4_interface as sd

# Assumes D is sorted!
def dlaed4(D, Z, rho, idx=1):
    """
       This subroutine computes the I-th updated eigenvalue of a symmetric
    rank-one modification to a diagonal matrix whose elements are
    given in the array d, and that

               D(i) < D(j)  for  i < j

    and that RHO > 0.  This is arranged by the calling routine, and is
    no loss in generality.  The rank-one modified system is thus

               diag( D )  +  RHO * Z * Z_transpose.

    where we assume the Euclidean norm of Z is 1.

    The method consists of approximating the rational functions in the
    secular equation by simpler interpolating rational functions."""
    assert rho > 0
    N = D.shape[0]
    Delta_out = np.empty(N, dtype=np.float64)
    return sd.dlaed4(
        n=np.intc(N),
        i=np.intc(idx),
        D=D.astype(np.float64),
        Z=Z.astype(np.float64),
        rho=np.float64(rho),
        Delta_out=Delta_out,
    )


def dlaed4_ex(D, Z, rho, idx=1):
    """
       This subroutine computes the I-th updated eigenvalue of a symmetric
    rank-one modification to a diagonal matrix whose elements are
    given in the array d, and that

               D(i) < D(j)  for  i < j

    and that RHO > 0.  This is arranged by the calling routine, and is
    no loss in generality.  The rank-one modified system is thus

               diag( D )  +  RHO * Z * Z_transpose.

    where we assume the Euclidean norm of Z is 1.

    The method consists of approximating the rational functions in the
    secular equation by simpler interpolating rational functions.

    This version returns (new eigenvalue, INFO CODE)
    """
    assert rho > 0
    N = D.shape[0]
    Delta_out = np.empty(N, dtype=np.float64)
    return sd.dlaed4_ex(
        n=np.intc(N),
        i=np.intc(idx),
        D=D.astype(np.float64),
        Z=Z.astype(np.float64),
        rho=np.float64(rho),
        Delta_out=Delta_out,
    )
