using RQDs
using PyPlot
using Statistics
using Random
using Distributions



Random.seed!(1)


# testing the function
λ = 0.3 # mean length of intact core pieces
N = 1_000_000 # number of Monte Carlo simulations

pieces = rand(Exponential(λ),N)

slots = pieces_to_slots(pieces)

rqds_6 = evaluate_rqd(slots,0.06)
rqds_10 = evaluate_rqd(slots,0.1)

figure()
plot(rqds_6,rqds_10,".")
