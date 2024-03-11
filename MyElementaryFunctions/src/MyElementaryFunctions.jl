module MyElementaryFunctions

import Polynomials: Polynomial
import ForwardDiff: derivative

export my_fast_2sum, my_fast_2sum_eft, my_2sum, my_2sum_eft, my_fast_mult_fma, my_fast_mult_fma_eft, my_Kahan_adpbc,my_Kahan_adpbc_bf, my_roots, my_all_roots, my_Chebyshev_points, my_Vandermonde_matrix,
my_Remez_minimax_approx, my_error_value_polynomial, my_error_value_polynomial_fma, my_refined_error_value_polynomial, my_refined_error_value_polynomial_fma


include("my_base_operators.jl")
include("my_Remez_minimax_approx.jl")
include("my_polynomials.jl")

end # module MyElementaryFunctions