module MyElementaryFunctions

export my_fast_2sum, my_fast_2sum_eft, my_2sum, my_2sum_eft, my_fast_mult_fma, my_fast_mult_fma_eft, my_Kahan_adpbc,my_Kahan_adpbc_bf, my_roots, my_all_roots, my_Chebyshev_points, my_Vandermonde_matrix,
my_Remez_minimax_approx


include("my_fast_2sum.jl")
include("my_2sum.jl")
include("my_fast_mult_fma.jl")
include("my_Kahan_adpbc.jl")
include("my_Remez_minimax_approx.jl")

end # module MyElementaryFunctions