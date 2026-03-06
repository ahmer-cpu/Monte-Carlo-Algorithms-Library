import numpy as np
import matplotlib.pyplot as plt

def backwards_brownian_bridge(n, T=1.0, seed=None):
    if seed is not None:
        np.random.seed(seed)

    t = np.linspace(0, T, n+1)  # t_0 to t_n
    W = np.zeros(n+1)          # W[0] = W(t_0) = 0
    Z = np.random.randn(n)     # Standard normals Z_1 to Z_n

    # Step 1: Generate W(t_n) ~ N(0, T)
    W[-1] = np.sqrt(T) * Z[0]

    # Step 2: Recursive simulation backward using the lemma
    for i in range(n-1, 0, -1):  # simulate W(t_i) backward
        t_ni = t[i]
        t_nip1 = t[i+1]
        t_0 = 0

        mu = W[i+1] * (t_ni - t_0) / (t_nip1 - t_0)
        sigma2 = (t_nip1 - t_ni) * (t_ni - t_0) / (t_nip1 - t_0)
        W[i] = mu + np.sqrt(sigma2) * Z[n - i]

    return t, W

# Run and plot
t, W = backwards_brownian_bridge(n=500, T=1.0, seed=42)

plt.plot(t, W)
plt.title("Backwards Simulated Brownian Motion")
plt.xlabel("t")
plt.ylabel("W(t)")
plt.grid(True)
plt.show()
