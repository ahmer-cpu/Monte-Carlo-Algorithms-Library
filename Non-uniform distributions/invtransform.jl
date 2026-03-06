using Plots

# Parameters
pvals = [0.2, 0.2, 0.4, 0.1, 0.1]
xvals = Float64.(1:5)

# Pre-compute cdf to avoid recomputing the aggregate sum per sample
cdf = cumsum(pvals)

# Inverse transform
function inv_transform_cdf(cdf::Vector{Float64}, x::Vector{Float64})
    u = rand()  # Xoshiro256++ (Default)
    # Default rand() function used to be MT19937
    # Now Xoshiro256++ is used in the newer versions of Julia

    for i in 1:length(cdf)
        if u < cdf[i]
            return x[i]
        end
    end
    
    return x[end]
end

# Generate samples
samples = [inv_transform_cdf(cdf, xvals) for _ in 1:1000]

# Only 5 bins — fast!
hist = histogram(samples;
    bins = 5,
    normalize = false,
    label = "Frequency",
    xlabel = "x",
    ylabel = "Frequency",
    title = "Inverse Transform Sampling"
)

# Save to PNG
# savefig(hist, "histogram.png")

display(hist)
readline()