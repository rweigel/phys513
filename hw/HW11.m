clear

Vs = 1;
rho1 = -1/7; % Not actually rho1; see notes.
rho2 = -1/5; % Not actually rho2; see notes.
lambda1 = 5e-3;
lambda2 = 10e-3;

l1 = lambda1;
l2 = (3/4)*lambda2;

beta1 = 2*pi/lambda1;
beta2 = 2*pi/lambda2;

V1p = Vs/(exp(1j*beta1*(l1+l2)) + rho1*exp(1j*beta1*(l1+l2)));
V2p = V1p*(exp(1j*beta1*l2) + rho1*exp(1j*beta1*l2)) / ...
          (exp(1j*beta2*l2) + rho2*exp(1j*beta2*l2));

x1 = [-(l1+l2):0.1e-3:-l1];
V1 = V1p*(exp(-1j*beta1*x1) + rho1*exp(1j*beta1*x1));
x2 = [-l1:0.1e-3:0];
V2 = V2p*(exp(-1j*beta2*x2) + rho2*exp(1j*beta2*x2));

clf;hold on; grid on;
plot(x1/1e-3, abs(V1),'k','LineWidth',2)
plot(x2/1e-3, abs(V2),'k','LineWidth',2)
legend('|V(x)/V_s|')
xlabel('x [cm]')

VSWR1 = (1+abs(rho1))/(1-abs(rho1));
VSWR2 = (1+abs(rho2))/(1-abs(rho2));
title(sprintf('VSWR_1 = %.2f; VSWR_2 = %.2f',VSWR1,VSWR2));

print('HW11.svg', '-dsvg');
print('HW11.png', '-dpng', '-r300'); 
