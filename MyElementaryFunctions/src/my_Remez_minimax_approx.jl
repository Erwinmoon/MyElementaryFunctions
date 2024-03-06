function my_all_roots(g::Function, a::Float64, b::Float64, e::Float64)
    # assume there are at most one root in each subintervals
    if a > b
        # checking [a,b] is nonempty 
        println("Wraning: [$a,$b] is empty!")
        return
    end

    h = (b - a) / 200;
    list_all_roots = Float64[];

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

function my_roots(g::Function, a::Float64, b::Float64, e::Float64)
    # find one root of 1-d Function g(x) in an interval [a , b] by Golden Section Method
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
    elseif g_a == 0
        return a
    elseif g_b == 0
        return b
    elseif g_mid == 0
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

function my_Chebyshev_points(n::Int, a::Float64, b::Float64)
    # generate n+2 Chebyshev points in [a, b]
    pts = Vector{Float64}(undef, n + 2);
    for k = 1 : 1 : n + 2
        pts[n+3-k] = cos((k-1) * pi / (n + 1));
    end
    pts = (a + b) / 2 .+ (b - a) / 2 .*pts;
    return pts
end

function my_Vandermonde_matrix(pts::Vector)
    # generate n+2 × n+2 Vandermonde_matrix in pts
    n = length(pts);
    vdm = Matrix{Float64}(undef, n, n);
    vdm[: , 1] .= 1.0;
    for k = 2 : 1 : n
        vdm[: , k] = vdm[: , k - 1] .* pts;
    end
    return vdm
end

function my_Remez_minimax_approx(f::Function, n::Int, a::Float64, b::Float64)
    # return the minimax approx Pn of f(x)
    pts = my_Chebyshev_points(n, a, b);
    lhs = my_Vandermonde_matrix(pts);
    rhs = f.(pts);
    for k = 1 : 1 : n + 2
        lhs[k , end] = (-1)^k;
    end
    coefficient = lhs \ rhs;



    

    
end