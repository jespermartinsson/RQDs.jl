module RQDs

using Statistics
using Random
using Distributions


export gen_rqds

function gen_rqds(λ,d_in,N)
    xs = rand(Exponential(λ),N)
    rqds = Float64[]

    l_in = 0.0
    l_tot = 0.0
    d_tot = 2.0

    for x in xs
        if l_tot == 0 && x > d_tot 
            push!(rqds, 1.0)
            continue
        end
            
        l_tot += x
        x_end = 0
        
        if l_tot < d_tot
            if x > d_in
                l_in += x
            end
        else
            x_end = l_tot - x - d_tot
            if x_end > d_in
                l_in += x_end
            end
            
            push!(rqds, l_in/d_tot)
            l_in = 0.0
            l_tot = 0.0
            
        end
        # println(x)
        # println(x_end)
        # println(l_tot)
        # println(l_in)
        # println(rqd)
    end
    return rqds
end


end # module
