function my_exp(t::T,N::Int) where T <: Number
    # compute exp(t) by restoring decomposition algorithm
    # note that t ∈ [0,1.56] can get the most accurate results for large N
    # the discrete base is {log(1 + 2.0^(-n))}
    # more greater N, more accurate results
    if t > 1.5
        m = floor(t);
        t = my_2sum(t, -m);
    else
        m = 0.0;
        t = t;
    end
    epx1 = BigFloat(2.718281828459045235360287471352662497757247093699959574966967627724076630353555);

    t_hat = 0;
    E = 1;

    for i = 1 : 1 : N + 1
        k = i - 1;
        delta = log(1 + 2.0^(-k));
        if t_hat + delta <= t
            d_hat = 1.0;
        else
            d_hat = 0.0;
        end
        t_hat = fma(d_hat, delta, t_hat);
        E = E * fma(d_hat, 2.0^(-k), 1);       
    end
    return T(epx1^m*E, RoundNearest)
end