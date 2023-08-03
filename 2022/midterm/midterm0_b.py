# Same as midterm0_a.py but equation for continuity of D at mid-point
# to allow permittivity to differ between [a,2a] and [2a,3a].

Nit = 200
n   = 7
h   = 2/(n-1);
im  = (n-1)/2
er  = 2;
s   = 0; # s = 0 => cartesian; s = 1 => spherical;

# If True, numerical potential is initialized with exact potential.
exact_initial = False 

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

def exact(r):
  psi = []
  for i in range(0, len(r)):
    psi.append(0)
    if s == 0:
      # Cartesian
      x = (r[i]-1)
      if i <= im:
        psi[i] = x/(1+1/er)
      else:
        psi[i] = (1-1/er)/(1+1/er) + x*(1/er)/(1+1/er)
    else:
      # Spherical
      psi[i] = (3/2)*(1-1/r[i])
  return psi

def printpsi(psi, k):
  if k >= 0:
    print("{0:3d} ".format(k), end='')
  else:
    # Exact solution is indicated with k = -1.
    print("    ".format(k), end='')
  for i in range(len(psi)):
    print("{1:5.3f} ".format(k, psi[i]), end='')
  print("")  

#psi = exact(r)
printpsi(psi, 0)

for k in range(Nit):
  for i in range(1, len(r) - 1):
    if i == im:
      psi_new[i] = (er*psi[i+1] + psi[i-1])/(1 + er)
    else:
      psi_new[i] = 0.5*psi[i+1]*(1 + s*h/r[i]) + 0.5*psi[i-1]*(1 - s*h/r[i])

  for i in range(1, len(r) - 1):
    psi[i] = psi_new[i]
    psi_new[i] = 0.

  printpsi(psi, k+1)

print("")
psi_ex = exact(r)
#printpsi(psi_ex, -1)

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


