using RQDs
using PyPlot
using Statistics
using Random
using Distributions



Random.seed!(1)


# testing the function
λ = 0.3 # mean length of intact core pieces
d_in = 0.1 #  
N = 1_000_000 # number of Monte Carlo simulations
rqds = gen_rqds(λ, d_in, N)

figure()
hist(rqds,round(Int,sqrt(length(rqds))))
xlabel("RQD")

# create a convertation plot in 2D and 3D
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






