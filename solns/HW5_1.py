import numpy as np

V = [80, 60, 100, 20] # Vl, Vb, Vt, Vr

#V = [np.pi/4, 0, 0, 0] # Vl, Vb, Vt, Vr
# Checks performed:
#   At grid points in Figure 1.20a,
#   1. For V = [1,0,0,0]
#      Φ1 = Φ3 and Φ2 = Φ4.
#   2. For V = [0,1,0,0]
#      Φ1 = Φ2 and Φ3 = Φ4.
#   3. Also checked other combinations of V with only one non-zero value.
#   4. For V = [0,0,0,0]
#      Φ1 = Φ2 = Φ3 = Φ4 = 0

xo = 1 
yo = 1

def exact(x, y):
  # Exact solution is in the form of a series sum.
  # Exact solution is approximated by first non-zero Nmax/2 terms in sum.
  Nmax = 100
  pi = np.pi
  sinh = np.sinh
  sin = np.sin
  P = 0.
  for n in np.arange(1, Nmax+1, 2):
      R1 = (4./pi)*(1/n)*(1./sinh(n*pi*xo/yo));
      R2 = (4./pi)*(1/n)*(1./sinh(n*pi*yo/xo));
      Pl =  V[0]*sin(n*pi*y/yo)*sinh(n*pi*(xo-x)/yo);
      Pr =  V[3]*sin(n*pi*y/yo)*sinh(n*pi*x/yo);
      Pb =  V[1]*sin(n*pi*x/xo)*sinh(n*pi*(yo-y)/xo);
      Pt =  V[2]*sin(n*pi*x/xo)*sinh(n*pi*y/xo);
      P = P + R1*Pl + R1*Pr + R2*Pt + R2*Pb;
  return P

print("Φ1 = {:.2f} (book 75.2)".format(exact(1/3, 2/3)))
print("Φ2 = {:.2f} (book 60.5)".format(exact(2/3, 2/3)))
print("Φ3 = {:.2f} (book 65.4)".format(exact(1/3, 1/3)))
print("Φ4 = {:.2f} (book 50.7)".format(exact(2/3, 1/3)))

"""_summary_
Φ1 = 78.07 (book 75.2)
Φ2 = 62.39 (book 60.5)
Φ3 = 67.61 (book 65.4)
Φ4 = 51.93 (book 50.7)
"""