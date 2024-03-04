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