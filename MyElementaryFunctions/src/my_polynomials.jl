function my_error_value_polynomial(a::Vector{T}, n::Int, xmin::T, xmax::T) where T <: Number
    # method for error of p(x) - p_hat(x)
    # where p(x) is the exact vaule of a (n-1)-order Polynomial at x, and p_hat(x) is computatin one by Horner without FMA
    # a is coeffs of p(x) like p(x) = a[n]x^(n-1) + ... + a[2]x + a[1], note that n is the exact length of a
    # x ∈ [xmin, xmax]
    # a, xmin, and xmax need to be same Number Type, such as Vector{Float64}, Float64, Float64
    if length(a) != n
        println("Warining: length of $a and $n is not match, input them again such that length($a) == $n !")
        return
    end
    if xmin > xmax
        println("Warning: [$(xmin), $(xmax)] is not a interval !")
        return
    end

    r = RoundNearest;
    smin = Vector{T}(undef,n)
    smax = Vector{T}(undef,n)
    err = Vector{T}(undef,n)
    pminhat = Vector{T}(undef,n)
    pmaxhat = Vector{T}(undef,n)
    delta = Vector{T}(undef,n)
    pmin = Vector{T}(undef,n)
    pmax = Vector{T}(undef,n)
    sminhat = Vector{T}(undef,n)
    smaxhat = Vector{T}(undef,n)
    epsilon = Vector{T}(undef,n)
    smin[n] = a[n];
    smax[n] = a[n];
    err[n] = 0.0;

    for i = n : -1 : 2
        pminhat[i] = min(smin[i] * xmin, smin[i] * xmax, smax[i] * xmin, smax[i] * xmax);
        pmaxhat[i] = max(smin[i] * xmin, smin[i] * xmax, smax[i] * xmin, smax[i] * xmax);
        delta[i] = 0.5 * eps(max(abs(pminhat[i]), abs(pmaxhat[i])));
        pmin[i] = T(pminhat[i],RoundNearest);
        pmax[i] = T(pmaxhat[i],RoundNearest);
        sminhat[i - 1] = pmin[i] + a[i - 1];
        smaxhat[i - 1] = pmax[i] + a[i - 1];
        epsilon[i - 1] = 0.5 * eps(max(abs(sminhat[i - 1]), abs(smaxhat[i - 1])));
        smin[i - 1] = T(sminhat[i - 1] , r);
        smax[i - 1] = T(smaxhat[i - 1] , r);
        err[i - 1] = err[i] * max(abs(xmin), abs(xmax)) + epsilon[i - 1] + delta[i];
    end
    return err[1]
end

function my_error_value_polynomial_fma(a::Vector{T}, n::Int, xmin::T, xmax::T) where T <: Number
    # method for error of p(x) - p_hat(x)
    # where p(x) is the exact vaule of a (n-1)-order Polynomial at x, and p_hat(x) is computatin one by Horner with FMA
    # a is coeffs of p(x) like p(x) = a[n]x^(n-1) + ... + a[2]x + a[1], note that n is the exact length of a
    # x ∈ [xmin, xmax]
    # a, xmin, and xmax need to be same Number Type, such as Vector{Float64}, Float64, Float64
    if length(a) != n
        println("Warining: length of $a and $n is not match, input them again such that length($a) == $n !")
        return
    end
    if xmin > xmax
        println("Warning: [$(xmin), $(xmax)] is not a interval!")
        return
    end

    r = RoundNearest;
    smin = Vector{T}(undef,n)
    smax = Vector{T}(undef,n)
    err = Vector{T}(undef,n)
    sminhat = Vector{T}(undef,n)
    smaxhat = Vector{T}(undef,n)
    epsilon = Vector{T}(undef,n)
    smin[n] = a[n];
    smax[n] = a[n];
    err[n] = 0.0;  
    
    for i = n : -1 : 2
        sminhat[i - 1] = a[i-1] + min(smin[i] * xmin, smin[i] * xmax, smax[i] * xmin, smax[i] * xmax);
        smaxhat[i - 1] = a[i-1] + max(smin[i] * xmin, smin[i] * xmax, smax[i] * xmin, smax[i] * xmax);
        epsilon[i - 1] = 0.5 * eps(max(abs(sminhat[i - 1]), abs(smaxhat[i - 1])));
        smin[i - 1] = T(sminhat[i - 1], r);
        smax[i - 1] = T(smaxhat[i - 1], r);
        err[i - 1] = fma(err[i], max(abs(xmin), abs(xmax)), epsilon[i - 1]);
    end
    return err[1]
end

function my_refined_error_value_polynomial(a::Vector{T}, n::Int, xmin::T, xmax::T, N::Int) where T <: Number
    # more accurate method for error of p(x) - p_hat(x)
    # using subintervals to improve accuration
    # more detials see Function "my_error_value_polynomial"
    if xmin > xmax
        println("Warning: [$(xmin), $(xmax)] is not a interval !")
        return
    end
    errmax = 0.0
    size = (xmax - xmin) / N;
    for i = 1 : 1 : N
        err = my_error_value_polynomial(a, n, xmin + (i-1) * size, xmin + i * size);
        if err > errmax
            errmax = err;
        end
    end
    return errmax
end

function my_refined_error_value_polynomial_fma(a::Vector{T}, n::Int, xmin::T, xmax::T, N::Int) where T <: Number
    # more accurate method for error of p(x) - p_hat(x)
    # using subintervals to improve accuration
    # more detials see Function "my_error_value_polynomial_fma"
    if xmin > xmax
        println("Warning: [$(xmin), $(xmax)] is not a interval !")
        return
    end
    errmax = 0.0
    size = (xmax - xmin) / N;
    for i = 1 : 1 : N
        err = my_error_value_polynomial_fma(a, n, xmin + (i-1) * size, xmin + i * size);
        if err > errmax
            errmax = err;
        end
    end
    return errmax
end