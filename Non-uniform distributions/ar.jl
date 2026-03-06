using Plots
using Statistics

# Inverse transform
function discrete(n::Int64)
    u = rand()
    return floor(Int, n * u + 1)
end

function ar(n::Int64, pvals::Vector{Float64}, c::Float64)
    run = true
    counter = 0
    while run
        counter += 1
        y = discrete(n)
        u = rand()
        if (c*u <= pvals[y] )
            run = false
            return y, counter
        end 
    end
end


n=4
pvals = [0.3, 0.2, 0.35, 0.15]
xvals = Float64.(1:n)

# Using pmf g(i) = 1/4 
c = 0.35;

results = [ar(n, pvals, c) for _ in 1:1000]

samples = [r[1] for r in results]
attempts = [r[2] for r in results]

println("Time Complexity: ", mean(10 * attempts))

# Only 5 bins — fast!
hist = histogram(samples;
    bins = 4,
    normalize = false,
    label = "Frequency",
    xlabel = "x",
    ylabel = "Frequency",
    title = "Acceptance-Rejection Sampling"
)

# Save to PNG   
# savefig(hist, "histogram2.png")
display(hist)
readline()