clear

Vs = 1;
rho1 = -1/7;
rho2 = -1/5;
lambda1 = 5e-3;
lambda2 = 10e-3;

l1 = lambda1;
l2 = (3/4)*lambda2;

beta1 = 2*pi/lambda1;
beta2 = 2*pi/lambda2;

V1p = Vs/(exp(1j*beta1*(l1+l2)) + rho1*exp(1j*beta1*(l1+l2)));
V2p = V1p*(exp(1j*beta1*l2) + rho1*exp(1j*beta1*l2)) / ...
          (exp(1j*beta2*l2) + rho2*exp(1j*beta2*l2));

x1 = [-15:0.1:-10]*1e-3;
V1 = V1p*(exp(-1j*beta1*x1) + rho1*exp(1j*beta1*x1));
x2 = [-10:0.1:0]*1e-3;
V2 = V2p*(exp(-1j*beta2*x2) + rho2*exp(1j*beta2*x2));

clf;hold on; grid on;
plot(x1, abs(V1),'k','LineWidth',2)
plot(x2, abs(V2),'k','LineWidth',2)
legend('|V(x)/V_s|')
xlabel('x [cm]')

print('HW11.svg', '-dsvg');
print('HW11.png', '-dpng', '-r300'); 
