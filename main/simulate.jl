using RQDs
using PyPlot
using Statistics
using Random
using Distributions



Random.seed!(1)


# testing the function
# create a convertation plot in 2D and 3D
λs =10 .^(range(-2,stop=1,length=100))
#λs = 0.01:0.01:2.0
factors = Float64[]
m_rqds_10 = Float64[]
m_rqds_6 = Float64[]
s_rqds_10 = Float64[]
s_rqds_6 = Float64[]
N = 1_000_000 # number of Monte Carlo simulations


for λ in λs
    println(λ)
    pieces = rand(Exponential(λ),N)

    slots = pieces_to_slots(pieces)

    rqd_6 = evaluate_rqd(slots,0.06)
    rqd_10 = evaluate_rqd(slots,0.1)

    m_rqd_6 = mean(rqd_6)
    m_rqd_10 = mean(rqd_10)
    s_rqd_6 = std(rqd_6)
    s_rqd_10 = std(rqd_10)
    push!(m_rqds_10,m_rqd_10)
    push!(m_rqds_6,m_rqd_6)
    push!(s_rqds_10,s_rqd_10)
    push!(s_rqds_6,s_rqd_6)
end

f(x) = 4.956588e-7.*x.^4 .- 6.04082e-5.*x.^3 .+ 0.0110462.*x.^2 .- 0.000937234.*x .+ 0.0606494

x = 0:0.01:1
figure()
plot(m_rqds_6, m_rqds_10,"k-", label=raw"Monte-Carlo generated",linewidth=2)
for i in 1:length(λs)
    plot(m_rqds_6[i] .+ [1,-1]*s_rqds_6[i], m_rqds_10[i]*[1,1],"k-",linewidth=0.5)
    plot(m_rqds_6[i]*[1,1], m_rqds_10[i] .+ [1,-1]*s_rqds_10[i],"k-",linewidth=0.5)
end
plot(x, f(x*100)/100,"r-", label=raw"P&H (1976)")
ylabel(raw"RQD$_{10}$")
xlabel(raw"RQD$_6$")
grid("on")
legend()
tight_layout()

figure()
plot3D(m_rqds_6, m_rqds_10,1 ./λs,"k-", label=raw"Monte-Carlo generated",linewidth=2)
for i in 1:length(λs)
    plot3D(m_rqds_6[i] .+ [1,-1]*s_rqds_6[i], m_rqds_10[i]*[1,1],1/λs[i]*[1,1],"k-",linewidth=0.5)
    plot3D(m_rqds_6[i]*[1,1], m_rqds_10[i] .+ [1,-1]*s_rqds_10[i],1/λs[i]*[1,1],"k-",linewidth=0.5)
end
plot(x, f(x*100)/100,"r-", label=raw"P&H (1976)")
ylabel(raw"RQD$_{10}$")
xlabel(raw"RQD$_6$")
zlabel(raw"$\lambda^{-1}$")
grid("on")
legend()
tight_layout()



