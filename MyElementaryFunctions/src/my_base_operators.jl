# the most accurate sum functions of two numbers
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

# the most accurate multiplication functions of two numbers
# inputing is two numbers in same type, for example a = 1.00000001(Float64) and b = 3.0(Float64)
# outputing is one number in Float64 p = RN(a + b), or two numbers in Float64 s + rou = a * b

function my_fast_mult_fma_eft(a :: T , b :: T) where T <: Number
    r = RoundNearest;
    a_big = BigFloat(string(a),r);
    b_big = BigFloat(string(b),r);
    p = a_big * b_big;
    rou =  fma(a_big, b_big, -p);
    return p, rou
end

function my_fast_mult_fma(a :: T , b :: T) where T <: Number
    r = RoundNearest;
    a_big = BigFloat(string(a),r);
    b_big = BigFloat(string(b),r);
    p = a_big * b_big;
    return Float64(p,r)
end

# the most accurate of ad - bc
# inputing is four numbers in same type, for example a = 1.00000001(Float64) and b = 3.0(Float64), c = 4.1(Float64), and d = 1.0(Float)
# outputing is one number in Float64 x = RN(ad-bc)

function my_Kahan_adpbc_bf(a::T,b::T,c::T,d::T) where T <: Number
    r = RoundNearest;
    a_big = BigFloat(string(a),r);
    b_big = BigFloat(string(b),r);
    c_big = BigFloat(string(c),r);
    d_big = BigFloat(string(d),r);
    w = b_big * d_big;
    e = fma(-b_big, c_big, w);
    f = fma(a_big, d_big, -w);
    x = Float64(f + e , r);
    return x
end

function my_Kahan_adpbc(a::T,b::T,c::T,d::T) where T <: Number
    w = b * d;
    e = fma(-b, c, w);
    f = fma(a, d, -w);
    x = f + e
    return x
end