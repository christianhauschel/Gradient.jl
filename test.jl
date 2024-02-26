using Gradient

using CSV, DataFrames

using PyCall, PyPlot 
pplt = pyimport("proplot")
pplt.close("all")

df = CSV.read("data/data.csv", DataFrame)

method = :akima



using ForwardDiff
using Dierckx

n_τ = length(df.τ)
τ = df.τ

s = 1e-5
k = 5
bc = "nearest"

spl = Spline1D(df.τ, df.Mr, k=k, s=s, bc=bc)
Mr_2 = spl(τ)

# Mr_τ2 = gradient(τ, Mr_2)
# Mr_ττ2 = gradient(τ, Mr_τ2)

Mr_τ2 = derivative(spl, τ)
spl_t = Spline1D(τ, Mr_τ2, k=k, s=s, bc=bc)
Mr_ττ2 = derivative(spl_t, τ)

fig, ax = pplt.subplots(nrows=3, sharex=true, figsize=(6,6))
ax[1].plot(τ, df.Mr, lw=1)
ax[2].plot(τ, df.Mr_τ, lw=1)
ax[3].plot(τ, df.Mr_ττ, lw=1)
ax[1].plot(τ, Mr_2, lw=1)
ax[2].plot(τ, Mr_τ2, lw=1)
ax[3].plot(τ, Mr_ττ2, lw=1)
fig