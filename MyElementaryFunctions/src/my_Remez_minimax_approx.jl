function my_all_roots(g::Function, a::T, b::T, e::Float64) where T <: Number
    # assume there are at most one root in each subintervals
    # e is the tolerance, |g(x)| < e means x is one of the root of g
    # smaller e, more accurate we would get
    # note that T is also the type of roots
    if a > b
        # checking [a,b] is nonempty  
        println("Wraning: [$a,$b] is empty!")
        return
    end

    h = (b - a) / 200;
    list_all_roots = T[];

    for k = 1 : 1 : 200
        left = a + (k - 1) * h;
        right = left + h;
        if g(left) * g(right) <= 0
            root = my_roots(g,left,right,e);
            if isempty(list_all_roots) || root != list_all_roots[end]
                append!(list_all_roots, root);
            end
        end
    end

    return list_all_roots
end

function my_roots(g::Function, a::T, b::T, e::Float64) where T <: Number
    # find one root of 1-d Function g(x) in an interval [a , b] by Golden Section Method
    # e is the tolerance, |g(x)| < e means x is one of the root of g
    # smaller e, more accurate we would get
    if a > b
        # checking [a,b] is nonempty 
        println("Wraning: [$a,$b] is empty!")
        return
    end

    g_a = g(a);
    g_b = g(b);
    mid = a + 0.618 * (b - a);
    g_mid = g(mid);

    if g_a * g_b > 0
        println("Wraning: there maybe be no root in [$a, $b]!")
        return
    elseif abs(g_a) <= e
        return a
    elseif abs(g_b) <= e
        return b
    elseif abs(g_mid) <= e
        return mid
    end

    while abs.(g_mid) > e && (b-a)>e
        if g_mid * g_a > 0
            a = mid;
        else 
            b = mid;
        end
        mid = a + 0.618 * (b - a)
        g_mid = g(mid);
    end

    return mid
end

function my_Chebyshev_points(n::Int, a::T, b::T) where T <: Number
    # generate n+2 Chebyshev points in [a, b]
    pts = Vector{T}(undef, n + 2);
    for k = 1 : 1 : n + 2
        pts[n+3-k] = cos((k-1) * pi / (n + 1));
    end
    pts = (a + b) / 2 .+ (b - a) / 2 .*pts;
    return pts
end

function my_Vandermonde_matrix(pts::Vector{T}) where T <: Number
    # generate n+2 × n+2 Vandermonde_matrix in pts
    n = length(pts);
    vdm = Matrix{T}(undef, n, n);
    vdm[: , 1] .= 1.0;
    for k = 2 : 1 : n
        vdm[: , k] = vdm[: , k - 1] .* pts;
    end
    return vdm
end

function my_Remez_minimax_approx(f::Function, n::Int, a::T, b::T, e::Float64) where T <: Number
    # return the minimax approx Pn of f(x) in [a,b]
    # a,b need to have the same type, such as Float64 or BigFloat
    # n is the degree of the Polynomial Pn
    # e is the tolerance, see also "my_all_roots, my_roots" 

    p = Polynomial([0.0]); 
    pts = my_Chebyshev_points(n, a, b);
    ratio = 2; 
    if T == BigFloat
        threshold = 1e-15;
    else
        threshold = sqrt(e); 
    end
    count = 1;

    while (ratio < 1 - threshold || ratio > 1 + threshold) && count < 1e4
        lhs = my_Vandermonde_matrix(pts);
        rhs = f.(pts);
        for k = 1 : 1 : n + 2
            lhs[k , end] = (-1)^k;
        end
        coeffs = lhs \ rhs;
        p = Polynomial(coeffs[1:end-1]); 

        dpdf = x -> derivative(p, x) - derivative(f, x);
        pts = my_all_roots(dpdf, a, b, e); 
        length_pts = length(pts);
        if length_pts > n + 2
            println("Wraning: there are extreme values, try another degree!")
            return
        elseif length_pts < n
            println("Wraning: not enough oscillations")
            return
        elseif length_pts == n
            pts = [a; pts; b];
        elseif length_pts == n + 1 && p(a) - f(a) > p(b) - f(b)
            pts = [a; pts];
        else
            pts = [pts; b];
        end
        Emax = maximum(p.(pts) .- f.(pts));
        Emin = minimum(p.(pts) .- f.(pts));
        if Emin != 0 
            ratio = abs(Emax / Emin);
        elseif Emax != 0
            ratio = 2;
        else 
            return
        end
        count = count + 1;  
        if count == 1e4
            # There are too many loops, so we can’t judge whether p is minimax approach of $f, but we still give an answer!
            println("Wraning: this Polynomial maybe not minimax approach of $f, try to change some parameters, such as size of interval and tolerance, or compute it in another way!")  
        end   
    end
    return p, ratio
end