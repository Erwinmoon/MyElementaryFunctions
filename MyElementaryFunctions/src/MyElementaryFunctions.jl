module MyElementaryFunctions

export my_fast_2sum, my_fast_2sum_eft, my_2sum, my_2sum_eft, my_fast_mult_fma, my_fast_mult_fma_eft, my_Kahan_adpbc,my_Kahan_adpbc_bf


include("my_fast_2sum.jl")
include("my_2sum.jl")
include("my_fast_mult_fma.jl")
include("my_Kahan_adpbc.jl")

end # module MyElementaryFunctions