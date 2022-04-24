export Episode, Episodes

struct Episode{T}
    traces::T
    is_done::Ref{Bool}
end

Base.getindex(e::Episode) = getindex(e.is_done)
Base.setindex!(e::Episode, x::Bool) = setindex!(e.is_done, x)

Episode(t::Traces) = Episode(t, Ref(false))

function Base.append!(t::Episode, x)
    if t.is_done[]
        throw(ArgumentError("The episode is already flagged as done!"))
    else
        append!(t.traces, x)
    end
end

function Base.push!(t::Episode, x)
    if t.is_done[]
        throw(ArgumentError("The episode is already flagged as done!"))
    else
        push!(t.traces, x)
    end
end

function Base.pop!(t::Episode)
    pop!(t.traces)
    t.is_done[] = false
end

Base.popfirst!(t::Episode) = popfirst!(t.traces)

function Base.empty!(t::Episode)
    empty!(t.traces)
    t.is_done[] = false
end

#####

struct Episodes{T}
    episodes::T
end

Base.lastindex(e::Episodes) = lastindex(e.episodes)
Base.length(e::Episodes) = length(e.episodes)
Base.getindex(e::Episodes, I...) = getindex(e.episodes, I...)

Base.push!(e::Episodes, x::Episode) = push!(e.episodes, x)
Base.append!(e::Episodes, x::AbstractVector{<:Episode}) = append!(e.episodes, x)
Base.pop!(e::Episodes) = pop!(e.episodes)
Base.popfirst!(e::Episodes) = popfirst!(e.episodes)
