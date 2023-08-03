# Solves 1-D problem with V(a) = 0 and V(b) = 1 and free space between
# in cartesian and spherical.

Nit = 200 # Number of iterations
n   = 13  # Number of grid points
h   = 2/(n-1);
s   = 0;  # s = 0 => cartesian; s = 1 => spherical;

r = []
psi = []
psi_new = []
for i in range(0, n):
  r.append(1 + i*h)
  psi.append(0.5)
  psi_new.append(0.0)

psi[0] = 0
psi[n-1] = 1
psi_new[0] = 0
psi_new[n-1] = 1

def printpsi(psi, k):
  if k >= 0:
    print("{0:3d} ".format(k), end='')
  else:
    # Exact solution is indicated with k = -1.
    print("    ".format(k), end='')
  for i in range(len(psi)):
    print("{1:5.3f} ".format(k, psi[i]), end='')
  print("")  

print("Numerical")
printpsi(psi, 0)

for k in range(Nit):
  for i in range(1, len(r) - 1):
    psi_new[i] = 0.5*psi[i+1]*(1 + s*h/r[i]) + 0.5*psi[i-1]*(1 - s*h/r[i])

  psi = psi_new
  printpsi(psi, k+1)

print("")
psi_ex = psi.copy()
for i in range(0, len(r)):
    if s == 0:
      psi_ex[i] = (1/2)*(r[i]-1)
    else:
      psi_ex[i] = (3/2)*(1-1/r[i])

print("Exact")
printpsi(psi_ex, -1)

if True:
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

