function my_2sum(a::T, b::T) where T <: Number
    a_big = BigFloat(a)
    b_big = BigFloat(b)
    sum = a_big + b_big
    a_prime = sum - b_big;
    b_prime = sum - a_prime;
    delta_a = a_big - a_prime;
    delta_b = b_big - b_prime;
    delta = delta_a + delta_b;
    return sum, delta
end