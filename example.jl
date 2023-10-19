using Gradient

x = Vector(LinRange(0, 1, 10))
y = x.^2

dydx = 2.0 .* x

dydx_approx = gradient(x, y)

using PyPlot, PyCall
pplt = pyimport("proplot")
pplt.close("all")

fig, ax = pplt.subplots()
ax[1].plot(x, dydx, "-", label="dydx exact")
ax[1].plot(x, dydx_approx, ".", label="dydx approx")
fig