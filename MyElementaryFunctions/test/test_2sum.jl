using MyElementaryFunctions

# this is test example for four sum functions of MyElementaryFunctions
# four functions is 
#   my_2sum
#   my_2sum_eft
#   my_fast_2sum
#   my_fast_2sum_eft
# inputing is two numbers in same type, for example a = 1.00000001(Float64) and b = 3.0(Float64)
# outputing is one number in Float64 s = RN(a + b), or two numbers in Float64 s + t = a + b


using Test

# test Integer
@testset "Integer inputs(my_2sum_eft) " begin
    sum, delta = my_2sum_eft(3, 4)
    @test sum == BigFloat(7)
    @test delta == BigFloat(0)
end

# test Float64
@testset "Floating-point inputs(my_2sum_eft)" begin
    sum, delta = my_2sum_eft(1.1, 2.2)
    @test sum ≈ BigFloat(3.3) atol=1e-10
    @test delta ≈ BigFloat(0) atol=1e-10
end

# test BigFloat
@testset "BigFloat inputs(my_2sum)" begin
    a = BigFloat("1.0000000000000000000000000000001")
    b = BigFloat("2.9999999999999999999999999999999")
    sum, delta = my_2sum_eft(a, b)
    @test sum ≈ BigFloat("4.0") atol=1e-30
    @test delta ≈ BigFloat("0") atol=1e-30
end

# test Integer
@testset "Integer inputs(my_2sum) " begin
    sum = my_2sum(3, 4)
    @test sum == BigFloat(7)
end

# test Float64
@testset "Floating-point inputs(my_2sum)" begin
    sum= my_2sum(1.1, 2.2)
    @test sum ≈ BigFloat(3.3) atol=1e-10
end

# test BigFloat
@testset "BigFloat inputs(my_2sum)" begin
    a = BigFloat("1.0000000000000000000000000000001")
    b = BigFloat("2.9999999999999999999999999999999")
    sum= my_2sum(a, b)
    @test sum ≈ BigFloat("4.0") atol=1e-30
end

# test Integer
@testset "Integer inputs(my_fast_2sum_eft) " begin
    sum, delta = my_fast_2sum_eft(3, 4)
    @test sum == BigFloat(7)
    @test delta == BigFloat(0)
end

# test Float64
@testset "Floating-point inputs(my_fast_2sum_eft)" begin
    sum, delta = my_fast_2sum_eft(1.1, 2.2)
    @test sum ≈ BigFloat(3.3) atol=1e-10
    @test delta ≈ BigFloat(0) atol=1e-10
end

# test BigFloat
@testset "BigFloat inputs(my_fast_2sum_eft)" begin
    a = BigFloat("1.0000000000000000000000000000001")
    b = BigFloat("2.9999999999999999999999999999999")
    sum, delta = my_fast_2sum_eft(a, b)
    @test sum ≈ BigFloat("4.0") atol=1e-30
    @test delta ≈ BigFloat("0") atol=1e-30
end

# test Integer
@testset "Integer inputs(my_fast_2sum) " begin
    sum = my_fast_2sum(3, 4)
    @test sum == BigFloat(7)
end

# test Float64
@testset "Floating-point inputs(my_fast_2sum)" begin
    sum= my_fast_2sum(1.1, 2.2)
    @test sum ≈ BigFloat(3.3) atol=1e-10
end

# test BigFloat
@testset "BigFloat inputs(my_fast_2sum)" begin
    a = BigFloat("1.0000000000000000000000000000001")
    b = BigFloat("2.9999999999999999999999999999999")
    sum= my_fast_2sum(a, b)
    @test sum ≈ BigFloat("4.0") atol=1e-30
end