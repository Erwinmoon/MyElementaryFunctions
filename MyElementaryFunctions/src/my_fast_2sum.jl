# the most accurate sum functions of two numbers
# inputing is two numbers in same type, for example a = 1.00000001(Float64) and b = 3.0(Float64)
# outputing is one number in Float64 s = RN(a + b), or two numbers in Float64 s + t = a + b

function my_fast_2sum_eft(a::T, b::T) where T <: Number
    r = RoundNearest;
    if a >= b
        a_big = BigFloat(string(a),r)
        b_big = BigFloat(string(b),r)
    else
        a_big = BigFloat(string(b),r)
        b_big = BigFloat(string(a),r)
    end
    sum = a_big + b_big
    b_virtual = sum - a_big
    delta = b_big - b_virtual
    return sum, delta
end

function my_fast_2sum(a::T, b::T) where T <: Number
    r = RoundNearest;
    if a >= b
        a_big = BigFloat(string(a),r)
        b_big = BigFloat(string(b),r)
    else
        a_big = BigFloat(string(b),r)
        b_big = BigFloat(string(a),r)
    end
    sum = a_big + b_big
    return Float64(sum, r)
end