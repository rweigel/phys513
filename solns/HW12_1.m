clear

set(0,'DefaultAxesFontName','Times');
set(0,'DefaultAxesTitleFontWeight','normal');
set(0,'DefaultAxesFontSize',16);
set(0,'DefaultTextFontName','Times');
set(0,'DefaultTextFontSize',16);
set(0,'defaultTextInterpreter','LaTeX')
set(0,'defaultLegendInterpreter','LaTeX');

N0 = 1000;

% w can be any value > 0 - answer does not depend on w because L0 and C0 
% are inversely proportional to w and in the calculation of Z, we multiply
% them by w. Here we keep w for so that formulas are in a familiar form.
w = 1; 
l0 = 0.5;
Z0 = 1;
Z1 = 3*Z0;

beta0 = 2*pi/l0;
lambda0 = 2*pi/beta0;
rho0 = (Z1-Z0)/(Z1+Z0);

% Compute inductance and capacitance per unit length. Note that in the
% continous transmission line equations, L and C are per unit length.
L0 = sqrt((beta0^2/w^2)*Z0^2);
C0 = L0/Z0^2;

dx0 = l0/N0;
dL0 = dx0*L0; % Differential inductance in H.
dC0 = dx0*C0; % Differential capacitance in F.

Z = zeros(1, N0);
Z(end) = Z1;

V(1) = 1.0;

for n = [N0:-1:2]
    y = 1/(Z(n) + 1j*w*dL0);
    Z(n-1) = 1/(y + 1j*w*dC0);
end

I(1) = V(1)/Z(1);
for n = [1:N0]
    I(n+1) = I(n) - 1j*w*dC0*V(n);
    V(n+1) = V(n) - 1j*w*dL0*I(n+1);
end

x = [0:dx0:l0];
Ve = V(1)*(exp(-1j*beta0*x) + rho0*exp(1j*beta0*x));
Ve = Ve/(exp(-1j*beta0*l0) + rho0*exp(1j*beta0*l0));

figure(1);clf;
subplot(2,1,1)
plot(x,abs(V));
hold on;
plot(x,abs(Ve))
subplot(2,1,2)
plot(x,abs(V)-abs(Ve));

print('HW12.svg', '-dsvg');
print('HW12.png', '-dpng', '-r300'); 

p = get(gcf,'Position');
orient tall
set(gcf,'PaperSize',[8.5,8])
print('HW12.pdf', '-dpdf');
