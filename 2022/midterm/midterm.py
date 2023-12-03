# If n = 7, non-general code is used.
# This code was written first and checked. Then, the more general code
# was implemented and checked that it gave the same result as n=7 code.

# If True, numerical potential is initialized with exact potential.
exact_initial = True

# If True, plot numerical and exact potential. Requires matplotlib.
plot = False

n   = 21 # Must be odd
er  = 2;
rho = 1;

h   = 2/(n-1) # Grid spacing
im  = int((n-1)/2) # Middle grid point

assert(n % 2 != 0 and n >=5, "n must be odd and >= 5")

if n == 7:
  # Non-general code
  h = 1/3
  r = [3/3, 4/3, 5/3, 6/3, 7/3, 8/3, 9/3]
else:
  r = []
  for i in range(0, n):
    r.append(1 + i*h)

def print_psi(psi, k):
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
    if i <= im:
      psi[i] = -(r[i]**2)/6.0 + c1/r[i] + c2
    if i > im:
      psi[i] = d1/r[i] + d2
  return psi


if exact_initial:
  psi = exact(r)
else:
  psi = [0, 0.5, 0.5, 0.5, 0.5, 0.5, 1.0]

print("Numerical")
print_psi(psi, 0)

k = 0
while True:

  psi_last = psi.copy()

  if n == 7:
    psi[1] = 0.5*psi[2]*(1 + h/r[1]) + 0.5*psi[0]*(1 - h/r[1]) + 0.5*rho*h**2
    psi[2] = 0.5*psi[3]*(1 + h/r[2]) + 0.5*psi[1]*(1 - h/r[2]) + 0.5*rho*h**2
    psi[3] = (er*psi[4] + psi[2])/(1 + er)
    psi[4] = 0.5*psi[5]*(1 + h/r[4]) + 0.5*psi[3]*(1 - h/r[4])
    psi[5] = 0.5*psi[6]*(1 + h/r[5]) + 0.5*psi[4]*(1 - h/r[5])
  else:
    source = (0.5)*rho*(h**2)
    for i in range(1, len(r) - 1):
      if i < im:
        psi[i] = 0.5*psi[i+1]*(1 + h/r[i]) + 0.5*psi[i-1]*(1 - h/r[i]) + source
      if i == im:
        psi[i] = (er*psi[i+1] + psi[i-1])/(1 + er)
      if i > im:
        psi[i] = 0.5*psi[i+1]*(1 + h/r[i]) + 0.5*psi[i-1]*(1 - h/r[i])

  max_psi_change = 0
  for i in range(1, len(r) - 1):
    max_psi_change = max(abs((psi[i] - psi_last[i])/psi[i]), max_psi_change)

  if max_psi_change < 0.01:
    print_psi(psi_last, k) # Print second-to-last iteration.
    print_psi(psi, k+1)    # Print last iteration.
    break

  k = k + 1

print("Exact")
print_psi(exact(r), -1)

if plot:
  from matplotlib import pyplot as plt
  plt.plot(r, psi, '*', label='numerical')
  plt.plot(r, exact(r), '-', label='exact')
  plt.legend()
  plt.ylabel('$\\Phi/V_o$', rotation=0)
  plt.xlabel('r/a')
  plt.grid()
  plt.show()
