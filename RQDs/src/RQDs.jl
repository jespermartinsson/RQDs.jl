module RQDs

using Statistics
using Random
using Distributions


export evaluate_rqd, pieces_to_slots


function pieces_to_slots(pieces, slot_length = 2.0)

    slots = Vector{Vector{Float64}}(undef,0)
    slot = Float64[]
    
    l = 0.0
    for piece in pieces
        l += piece
        if l <= slot_length
            push!(slot,piece)
        else
            outside = l - slot_length
            while outside > slot_length 
                push!(slots,Float64[slot_length])
                outside -= slot_length
                piece -= slot_length  
            end
            if outside < slot_length
                inside = piece - outside  
                push!(slot,inside)
                push!(slots,slot)
                slot = Float64[outside]
                l = outside
            else

            end
        end
    end
    return slots
end


function evaluate_rqd(slots, d_in)
    slot_length = sum(slots[1])
    N = length(slots)
    rqds = Vector{Float64}(undef,N)

    for i in 1:N
        l_in = 0.0
        for piece in slots[i]
            if piece > d_in
                l_in += piece
            end
        end
        rqds[i] = l_in/slot_length
    end
    return rqds
end


end # module
