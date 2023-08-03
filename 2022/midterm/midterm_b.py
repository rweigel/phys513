# Generalization of midterm_a.py.

Nit = 999          # Number of iterations
n   = 7            # Must be odd
im  = int((n-1)/2) # Middle grid point
h   = 2/(n-1)      # Grid spacing
er  = 2   # exact solution available for er = 1 and 2.
rho = 1   # exact solution available only for rho = 1.
s   = 1   # s = 0 => cartesian; s = 1 => spherical;

# If False and n = 7, will give same result as midterm_a.py
exact_initial = False 

r = []
psi = []
psi_new = []
for i in range(0, n):
  r.append(1 + i*h)
  psi.append(0.5)
  psi_new.append(0.0)

# Set boundary conditions
psi[0] = 0
psi[n-1] = 1
psi_new[0] = 0
psi_new[n-1] = 1

def exact(r):
  assert(rho == 1 and (er == 1 or er == 2))
  if s == 1:
    if er == 2:
      # er = 2
      # https://www.wolframalpha.com/input?i=c1+%2B+c2+%3D+1%2F6%2C+++++++-c1%2F8+%2B+d1%2F4+%3D+1%2F3%2C++++++d1%2F3+%2B+d2+%3D+1%2C+++++c1%2F2+%2B+c2+-+d1%2F2+-+d2+%3D+2%2F3
      c1 = -62./21.
      c2 =  131./42.
      d1 =  -1./7.
      d2 =  22./21.
    else:
      # er = 1
      # https://www.wolframalpha.com/input?i=c1+%2B+c2+%3D+1%2F6%2C+++++++-c1%2F4+%2B+d1%2F4+%3D+2%2F3%2C++++++d1%2F3+%2B+d2+%3D+1%2C+++++c1%2F2+%2B+c2+-+d1%2F2+-+d2+%3D+2%2F3
      c1 = -35./12.
      c2 =  37./12.
      d1 =  -1./4.
      d2 =  13/12.

  psi = []
  for i in range(0, len(r)):
    psi.append(0)
    if s == 1:
      if i <= im:
        psi[i] = -(r[i]**2)/6.0 + c1/r[i] + c2
      if i > im:
        psi[i] = d1/r[i] + d2
    else:
      x = (r[i]-1)/2
      if i <= im:
        psi[i] = -(x**2)/2.0 + (11./8.)*x
      if i > im:
        psi[i] = 1.0/8.0 + (7.0/8.0)*x

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

if exact_initial == True:
  psi = exact(r)

if n < 10:
  print("Numerical")
  printpsi(psi, 0)

for k in range(Nit):
  for i in range(1, len(r) - 1):
    if s == 1:
      source = (0.5)*rho*(h**2)/(r[i]**2)
    else:
      source = (0.5)*rho*(h**2)/(2**2)

    if i < im:
      psi_new[i] = 0.5*psi[i+1]*(1 + s*h/r[i]) + 0.5*psi[i-1]*(1 - s*h/r[i]) + source
    if i == im:
      psi_new[i] = (er*psi[i+1] + psi[i-1])/(1 + er)
    if i > im:
      psi_new[i] = 0.5*psi[i+1]*(1 + s*h/r[i]) + 0.5*psi[i-1]*(1 - s*h/r[i])

  for i in range(1, len(r) - 1):
    psi[i] = psi_new[i]

  if n < 10:
    printpsi(psi, k+1)

psi_ex = exact(r)
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


