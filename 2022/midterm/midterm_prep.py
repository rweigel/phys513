# Solves a 1-D problem with V(1) = 0 and V(3) = 1 in range [1,3] in cartesian
# and spherical. Written to work without imports.

problem = 1 # Free space

problem = 2 # Two dielectrics with ratio er = 2
er = 2.0

problem = 3 # rho_o in r = [1,3]
rho_o = 1.0 # Charge density

coord_sys = 1 # 0 => cartesian; 1 => spherical;

plot = False # Requires matplotlib if True.
n    = 7     # Number of grid points; must be odd.
h    = 2/(n-1)

r = []
psi = []
for i in range(0, n):
  r.append(1 + i*h)
  psi.append(0.5)

psi[0] = 0
psi[n-1] = 1

def exact(r, coord_sys=0, problem=1):

  psi_ex = []
  for i in range(0, len(r)):

    if problem == 1 or problem == 3: 
      # Free space
      if coord_sys == 0:
        psi_ex.append((1/2)*(r[i]-1))
      else:
        psi_ex.append((3/2)*(1-1/r[i]))

    if problem == 2: 
      # Two dielectrics; epsilon1 in r = [1,2], epsilon2 in r = [2,3].
      # er = epsilon2/epsilon1
      im  = (n-1)/2 # Middle index
      if coord_sys == 0:
        # Cartesian
        x = (r[i]-1)
        if i <= im:
          psi_ex.append(x/(1+1/er))
        else:
          psi_ex.append((1-1/er)/(1+1/er) + x*(1/er)/(1+1/er))
      else:
        pass

    if problem == 3:
      # rho_o in r = [1,2], epsilon in r = [2,3].
      # epsilon/epsilon_o = 2
      rho_o = 1.0
      if coord_sys == 0:
        # Cartesian
        psi_ex = psi_ex[i] - rho_o*(r[i]**2)/2.0 + 2*rho_o*r[i] - 3*rho_o/2.0
      else:
        # Spherical
        c1 = -2*rho_o
        c2 = (13/6)*rho_o
        psi_ex[i] = psi_ex[i] - rho_o*(r[i]**2)/6.0 + c1/r[i] + c2

  return psi_ex

def mae(psi, psi_ex):
  err = 0
  for i in range(len(psi)):
    err = max(abs(psi[i] - psi_ex[i])/n, err)
  return err

def print_psi(psi, k):
  if k >= 0:
    print("{0:3d} ".format(k), end='')
  else:
    # Exact solution is indicated by passing k = -1.
    print("    ".format(k), end='')
  for i in range(len(psi)):
    print("{1:5.4f} ".format(k, psi[i]), end='')
  print("")

def plot_psi(psi, psi_ex, mae=None, n=None):
  from matplotlib import pyplot as plt
  plt.plot(r, psi, '*', label='numerical')
  plt.plot(r, psi_ex, '-', label='exact')
  plt.legend()
  plt.ylabel('$\\Phi/V_o$', rotation=0)
  if s == 0:
    plt.xlabel('x/a')
  else:
    plt.xlabel('r/a')
  plt.grid()
  plt.show()

print(f"Numerical (n = {n})")
print_psi(psi, 0)

k = 0
s = 1
if coord_sys == 0:
  s = 0

while True:

  max_psi_change = 0
  psi_last = psi.copy() # Needed for printing at last iteration.

  for i in range(1, len(r) - 1):
    if problem == 3:
      if s == 0:
        source = (0.5)*rho_o*(h**2)
      else:
        source = (0.5)*rho_o*(h**2)

      psi_new = 0.5*psi[i+1]*(1 + s*h/r[i]) + 0.5*psi[i-1]*(1 - s*h/r[i]) + source
    else:
      psi_new = 0.5*psi[i+1]*(1 + s*h/r[i]) + 0.5*psi[i-1]*(1 - s*h/r[i])

    max_psi_change = max(abs((psi_new - psi[i])/psi[i]), max_psi_change)
    psi[i] = psi_new

  k = k + 1

  if k == 1:
    print_psi(psi, k)
    print("...")

  if max_psi_change < 0.01:
    print_psi(psi_last, k) # Print second-to-last iteration.
    print_psi(psi, k+1)    # Print last iteration.
    break

psi_exact = exact(r, coord_sys, problem)

print("")
print("Exact")
print_psi(psi_exact, -1)
print("\nMean absolute error: {0:5.3e}".format(mae(psi, psi_exact)))

if plot_psi:
  plot_psi(psi, psi_exact, mae=mae, n=n)