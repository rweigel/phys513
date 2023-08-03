# Non-general solution to mid-term problem.

Nit = 999
h   = 1/3
er  = 2;
rho = 1;
r       = [3/3, 4/3, 5/3, 6/3, 7/3, 8/3, 9/3]
psi_new = [0,     0,   0,   0,   0,   0, 1.0]

# If True, numerical potential is initialized with exact potential.
exact_initial = True 

def printpsi(psi, k):
  if k >= 0:
    print("{0:3d} ".format(k), end='')
  else:
    # Exact solution is indicated with k = -1.
    print("    ".format(k), end='')
  for i in range(len(psi)):
    print("{1:5.3f} ".format(k, psi[i]), end='')
  print("")  

def exact(r):

  # https://www.wolframalpha.com/input?i=c1+%2B+c2+%3D+1%2F6%2C+++++++-c1%2F8+%2B+d1%2F4+%3D+1%2F3%2C++++++d1%2F3+%2B+d2+%3D+1%2C+++++c1%2F2+%2B+c2+-+d1%2F2+-+d2+%3D+2%2F3
  c1 = -62./21.
  c2 =  131./42.
  d1 =  -1./7.
  d2 =  22./21.

  psi = []
  for i in range(0, len(r)):
    psi.append(0)
    if i <= 3:
      psi[i] = -(r[i]**2)/6.0 + c1/r[i] + c2
    if i > 3:
      psi[i] = d1/r[i] + d2
  return psi

if exact_initial:
  psi = exact(r)
else:
  psi = [0, 0.5, 0.5, 0.5, 0.5, 0.5, 1.0]

print("Numerical")
printpsi(psi, 0)

for k in range(Nit):
  psi_new[1] = 0.5*psi[2]*(1 + h/r[1]) + 0.5*psi[0]*(1 - h/r[1]) + 0.5*rho*h**2/(r[1]**2)
  psi_new[2] = 0.5*psi[3]*(1 + h/r[2]) + 0.5*psi[1]*(1 - h/r[2]) + 0.5*rho*h**2/(r[2]**2)
  psi_new[3] = (er*psi[4] + psi[2])/(1 + er)
  psi_new[4] = 0.5*psi[5]*(1 + h/r[4]) + 0.5*psi[3]*(1 - h/r[4])
  psi_new[5] = 0.5*psi[6]*(1 + h/r[5]) + 0.5*psi[4]*(1 - h/r[5])

  for j in range(len(psi)):
    psi[j] = psi_new[j]

  printpsi(psi, k+1)

print("Exact")
printpsi(exact(r), -1)

if True:
  from matplotlib import pyplot as plt
  plt.plot(r, psi, '*', label='numerical')
  plt.plot(r, exact(r), '-', label='exact')
  plt.legend()
  plt.ylabel('$\\Phi/V_o$', rotation=0)
  plt.xlabel('r/a')
  plt.grid()
  plt.show()
