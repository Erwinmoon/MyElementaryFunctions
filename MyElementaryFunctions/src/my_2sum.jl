# most accurest sum functions of two numbers
# inputing is two numbers in same type, for example a = 1.00000001(Float64) and b = 3.0(Float64)
# outputing is one number in Float64 s = RN(a + b), or two numbers in Float64 s + t = a + b


function my_2sum_eft(a::T, b::T) where T <: Number
    r = RoundNearest;
    a_big = BigFloat(string(a),r);
    b_big = BigFloat(string(b),r);
    sum = a_big + b_big;
    a_prime = sum - b_big;
    b_prime = sum - a_prime;
    delta_a = a_big - a_prime;
    delta_b = b_big - b_prime;
    delta = delta_a + delta_b;
    return sum, delta
end

function my_2sum(a::T, b::T) where T <: Number
    r = RoundNearest;
    a_big = BigFloat(string(a),r);
    b_big = BigFloat(string(b),r);
    sum = a_big + b_big;
    return Float64(sum, r)
end