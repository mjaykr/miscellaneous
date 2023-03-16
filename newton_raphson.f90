! newton_raphson.f90
program newton_raphson
    implicit none

    ! Declare variables
    integer, parameter :: n = 3
    real(8) :: x(n), x_old(n), f(n), J(n,n), J_inv(n,n)
    real(8) :: tol, err
    integer :: iter, max_iter

    ! Define parameters
    tol = 1.0d-7
    max_iter = 500

    ! Initial guess
    x = (/ 1.0d0, 1.0d0, 1.0d0 /)

    ! Newton-Raphson iterations
    iter = 0
    do
        x_old = x
        call evaluate_f(x, f)
        call evaluate_jacobian(x, J)
        call invert_matrix(J, J_inv)
        x = x - matmul(J_inv, f)

        ! Calculate error
        err = maxval(abs(x - x_old))
        iter = iter + 1
        if (err < tol .or. iter > max_iter) exit
    end do

    ! Display results
    print *, "Solution:"
    print *, x
    print *, "Number of iterations:", iter

contains

    subroutine evaluate_f(x, f)
        real(8), intent(in) :: x(n)
        real(8), intent(out) :: f(n)

        ! Define nonlinear equations (replace with your own equations)
        f(1) = x(1)**2 + x(2)**2 + x(3)**2 - 1.0d0
        f(2) = x(1) + x(2)**3 - x(3)**2 - 2.0d0
        f(3) = x(1)*x(2) - x(3) + 1.0d0
    end subroutine

    subroutine evaluate_jacobian(x, J)
        real(8), intent(in) :: x(n)
        real(8), intent(out) :: J(n,n)

        ! Define Jacobian matrix (replace with derivatives of your equations)
        J(1,1) = 2.0d0 * x(1)
        J(1,2) = 2.0d0 * x(2)
        J(1,3) = 2.0d0 * x(3)

        J(2,1) = 1.0d0
        J(2,2) = 3.0d0 * x(2)**2
        J(2,3) = -2.0d0 * x(3)

        J(3,1) = x(2)
        J(3,2) = x(1)
        J(3,3) = -1.0d0
    end subroutine

    subroutine invert_matrix(A, A_inv)
        real(8), intent(in) :: A(n,n)
        real(8), intent(out) :: A_inv(n,n)
        real(8) :: work(n*n)
        integer :: ipiv(n), info

        A_inv = A
        call dgetrf(n, n, A_inv, n, ipiv, info)
        if (info /= 0) then
            print *, "Matrix inversion failed (LU factorization)."
            stop
        end if

        call dgetri(n, A_inv, n, ipiv, work, n*n, info)
        if (info /= 0) then
            print *, "Matrix inversion failed (matrix inverse calculation)."
            stop
        end if
    end subroutine invert_matrix

end program newton_raphson