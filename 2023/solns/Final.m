clear

set(0,'DefaultAxesFontName','Times');
set(0,'DefaultAxesTitleFontWeight','normal');
set(0,'DefaultTextFontName','Times');
set(0,'DefaultTextFontSize',16);
set(0,'DefaultAxesFontSize',16);

N = 2000;

w = 1e6; % Does not matter. Note cancellation. Should remove.

if 0
    l1 = 1;
    l2 = 1;    
    Z01 = 10;
    Z02 = 20;
    Z03 = 40;
    beta1 = 10; % w*sqrt(L1o*C1o);
    beta2 = 20;
end

Z01 = 1;
Z02 = Z01/2;
Z03 = Z01/3;
beta1 = 2*pi/0.1;
beta2 = 2*pi/0.05;
lambda1 = 2*pi/beta1;
lambda2 = 2*pi/beta2;

l1 = lambda1;
l2 = (3/4)*lambda2;
N1 = round(N*l1/(l1+l2));
N2 = N-N1;

L01o = sqrt((beta1^2/w^2)*Z01^2);
L02o = sqrt((beta2^2/w^2)*Z02^2);

C01o = L01o/Z01^2;
C02o = L02o/Z02^2;

dx1 = l1/N1;
dL1 = dx1*L01o; 
dC1 = dx1*C01o;

dx2 = l2/N2;
dL2 = dx2*L02o;
dC2 = dx2*C02o;

Z = zeros(1, N);
Z(end) = Z03;

V(1) = 1.0;

for n = [N:-1:2]
    if n > N1
        L = dL2;
        C = dC2;
    else
        L = dL1;
        C = dC1;
    end
    y = 1/(Z(n) + 1j*w*L);
    Z(n-1) = 1/(y + 1j*w*C);
end

I(1) = V(1)/Z(1);
xe(1) = -(l1+l2);
for n = [1:N-1]
    if n > N1
        xe(n+1) = xe(n) + dx2;
        L = dL2;
        C = dC2;
    else
        xe(n+1) = xe(n) + dx1;
        L = dL1;
        C = dC1;
    end
    I(n+1) = I(n) - 1j*w*C*V(n);
    V(n+1) = V(n) - 1j*w*L*I(n+1);
end

rho2 = (Z(end)/Z02 - 1)/(Z(end)/Z02 + 1);

rho2r = rho2*exp(-2j*beta2*l2); % rho2 rotated
z = (Z02/Z01)*(1 + rho2r)/(1 - rho2r);
rho1 = exp(2j*beta1*l2)*(z - 1)/(z + 1);

%xe = (l1+l2)*([0:N-1]/(N-1) - 1);

Vs = 1;
x1 = xe(xe < -l2);
V1p = Vs/ (exp( 1j*beta1*(l1+l2)) + rho1*exp(-1j*beta1*(l1+l2)));
V1  = V1p*(exp(-1j*beta1*x1)      + rho1*exp( 1j*beta1*x1));

x2  = xe(xe >= -l2);
V2p = V1p*(exp(1j*beta1*l2) + rho1*exp(-1j*beta1*l2)) ...
         /(exp(1j*beta2*l2) + rho2*exp(-1j*beta2*l2));
V2  = V2p*(exp(-1j*beta2*x2) + rho2*exp(1j*beta2*x2));

Ve = [V1, V2]; % Exact
Va = V;        % TL approximation

if 1
titlestr = sprintf(...
    ['N = %d; \\rho_1=%.3f + %.3fj; \\rho_2=%.3f + %.3fj;',...
     '\\lambda_1=%.3f [m]; \\lambda_2=%.3f [m]'],...
    N,real(rho1),imag(rho1),real(rho2),imag(rho2),...
    lambda1,lambda2);

clf;
PositionTop = [0.1300 0.5400 0.7750 0.4];
PositionBottom = [0.1300 0.1100 0.7750 0.4];
subplot('Position',PositionTop)
    hold on;
    plot(xe,abs(Ve),'r','LineWidth',3);
    plot(xe,abs(Va),'b','LineWidth',1);
    %xlabel('$x$ [m]','Interpreter','Latex');
    set(gca, 'XTickLabels', []);        
    ylabel('[V]','Interpreter','Latex');
    title(titlestr);
    grid on;
    box on;
    legend('$|\widetilde{V}_{e}|$ (exact)','$|\widetilde{V}_a|$ (approx)',...
           'Interpreter','Latex','Orientation','Horizontal','Location','SouthEast')
subplot('Position',PositionBottom)
    plot(xe, (abs(Ve) - abs(Va))./abs(Ve),'k','LineWidth',2);
    xlabel('$x$ [m]','Interpreter','Latex')
    ylabel('[V]','Interpreter','Latex')
    grid on;
    legend('$(|\widetilde{V}_e| - |\widetilde{V}_a|)/|\widetilde{V}_e|$',...
        'Interpreter','Latex','Orientation','Horizontal','Location','SouthEast')

print('Final.svg', '-dsvg');
print('Final.png', '-dpng', '-r300'); 

p = get(gcf,'Position');
orient tall
set(gcf,'PaperSize',[8.5,8])
print('final.pdf', '-dpdf');
end
