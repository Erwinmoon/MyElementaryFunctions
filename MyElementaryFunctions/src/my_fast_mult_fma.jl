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