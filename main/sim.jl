using RQDs
using PyPlot
using Statistics
using Random
using Distributions


Random.seed!(1)




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


rqds = gen_rqds(1.0,0.1,100_000)
figure()
hist(rqds,round(Int,sqrt(length(rqds))))

λs = 0.01:0.01:10.0
factors = Float64[]
rqds_10 = Float64[]
rqds_6 = Float64[]

for λ in λs
    println(λ)
    N = 1000_000
    rqd_10 = mean(gen_rqds(λ,0.1,N))
    rqd_6 = mean(gen_rqds(λ,0.06,N))
    push!(factors,rqd_10/rqd_6)
    push!(rqds_10,rqd_10)
    push!(rqds_6,rqd_6)
end

figure()
plot(rqds_10,rqds_6,".-")
xlabel(raw"RQD$_{10}$")
ylabel(raw"RQD$_6$")
grid("on")


figure()
plot3D(rqds_10,rqds_6,λs, ".-")
xlabel(raw"RQD$_{10}$")
ylabel(raw"RQD$_6$")
zlabel(raw"$\lambda$")
grid("on")






