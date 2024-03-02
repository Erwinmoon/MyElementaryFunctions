function my_fast_2sum(a::T, b::T) where T <: Number
    if a >= b
        a_big = BigFloat(a)
        b_big = BigFloat(b)
    else
        a_big = BigFloat(b)
        b_big = BigFloat(a)
    end
    sum = a_big + b_big
    b_virtual = sum - a_big
    delta = b_big - b_virtual
    refined_sum = sum + delta
    return refined_sum, delta
end