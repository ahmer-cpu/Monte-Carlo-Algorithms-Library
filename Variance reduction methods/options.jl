using Distributions
using Plots
using Statistics

stdn=Normal(0,1)

phi(x)=cdf(stdn,x);

function bsm(r,sigma,S,K,T)
    d1=(log(S/K)+(r+sigma^2/2)*T)/(sigma*sqrt(T))
    d2=d1-sigma*sqrt(T)
    S*phi(d1)-K*exp(-r*T)*phi(d2)
end

function AsianArithPriceCrude(r,sigma,szero,K,T,n,N)
    # n is the number of time steps, h=T/n
    h=T/n
    price=0
    for i in 1:N
        sum=0
        s=szero
        for j in 1:n
            s=s*exp((r-sigma^2/2)*h+sigma*sqrt(h)*randn())
            sum=sum+s
        end
        price=price+max(sum/n-K,0)
    end
    exp(-r*T)*price/N
end

function EuroCallPriceCrude(r,sigma,szero,K,T,N)
    sum=0
    for i in 1:N
        sfinal=szero*exp((r-sigma^2/2)*T+sigma*sqrt(T)*randn())
        sum=sum+max(sfinal-K,0)
    end
    return price=exp(-r*T)*sum/N
    println("Crude MC call option price: $price")
end



function AsianArithPriceControl(r, sigma, szero, K, T, n, N)
    # n is the number of time steps, h = T/n
    h = T / n
    bsp = bsm(r, sigma, szero, K, T)

    prsum = 0
    csum = 0
    ysum = 0
    price = 0
    y = Array{Float64}(undef, N)
    c = Array{Float64}(undef, N)

    for i in 1:N
        sum = 0
        s = szero
        for j in 1:n
            s = s * exp((r - sigma^2 / 2) * h + sigma * sqrt(h) * randn())
            sum += s
        end

        y[i] = exp(-r * T) * max(sum / n - K, 0)
        c[i] = exp(-r * T) * max(s - K, 0)
    end

    ybar = sum(y) / N
    cbar = sum(c) / N

    for i in 1:N
        prsum += (y[i] - ybar) * (c[i] - cbar)
        csum += (c[i] - cbar)^2
        ysum += (y[i] - ybar)^2
    end

    beta = prsum / csum
    rho = prsum / (sqrt(csum) * sqrt(ysum))

    for i in 1:N
        price += y[i] - beta * (c[i] - bsp)
    end

    return price / N
end


# println("\nRunning simulations for variance comparison...\n")

# @time CrudeEstimates = [AsianArithPriceCrude(0.035, 0.2, 100, 90, 1, 20, 100000) for _ in 1:50];
# @time ControlEstimates = [AsianArithPriceControl(0.035, 0.2, 100, 90, 1, 20, 100000) for _ in 1:50];

# var_crude = var(CrudeEstimates)
# var_control = var(ControlEstimates)
# vrf = var_crude / var_control

# println("\n--- Variance Comparison Results ---")
# println("Variance of Crude Estimates:    $var_crude")
# println("Variance of Control Estimates:  $var_control")
# println("Variance Reduction Factor:      $(round(vrf, digits=2))x")


# histogram([CrudeEstimates ControlEstimates], 
#     label = ["Crude" "Control"], 
#     bins = 20, 
#     title = "Asian Option Estimation Variance Comparison",
#     xlabel = "Option Price Estimate", 
#     ylabel = "Frequency", 
#     legend = :topright)

    
# savefig("asian_option_variance_comparison.png")

σ_vals = [0.1, 0.2, 0.3, 0.4]
K_vals = [80, 90, 100, 110]
n_trials = 30
N = 100000
n = 20
T = 1.0
r = 0.035
szero = 100

results = []

for σ in σ_vals, K in K_vals
    crude = [AsianArithPriceCrude(r, σ, szero, K, T, n, N) for _ in 1:n_trials]
    control = [AsianArithPriceControl(r, σ, szero, K, T, n, N) for _ in 1:n_trials]

    var_crude = var(crude)
    var_control = var(control)
    vrf = var_crude / var_control

    push!(results, (σ, K, var_crude, var_control, vrf))
end

println("\\begin{tabular}{ccccc}")
println("\\toprule")
println("\\(\\sigma\\) & \\(K\\) & Crude Variance & Control Variance & Variance Reduction \\\\ \\midrule")

for (σ, K, vc, vctrl, vrf) in results
    println("$(σ) & $(K) & $(round(vc, digits=6)) & $(round(vctrl, digits=6)) & $(round(vrf, digits=2))x \\\\")
end

println("\\bottomrule")
println("\\end{tabular}")

# Convert results into matrices
z_crude = reshape([r[3] for r in results], (length(σ_vals), length(K_vals)))
z_control = reshape([r[4] for r in results], (length(σ_vals), length(K_vals)))
z_vrf = reshape([r[5] for r in results], (length(σ_vals), length(K_vals)))

heatmap(K_vals, σ_vals, z_vrf,
    xlabel = "Strike K",
    ylabel = "Volatility σ",
    title = "Variance Reduction Factor (Crude / Control)",
    c = :viridis,
    colorbar_title = "VRF")

savefig("vrf_heatmap.png")