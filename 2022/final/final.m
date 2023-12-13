clear

set(0,'DefaultAxesFontName','Times');
set(0,'DefaultAxesTitleFontWeight','normal');
set(0,'DefaultTextFontName','Times');
set(0,'DefaultTextFontSize',16);
set(0,'DefaultAxesFontSize',16);

N = 2000;

L1o = 0.0001; % L in [H]. L in [H]/[m] is same b/c length is 1 m.
C1o = 1e-6;   % C in [F]. C in [F]/[m] is same b/c length is 1 m.
L2o = 0.0004; % L in [H]. L in [H]/[m] is same b/c length is 1 m.
C2o = 1e-6;   % C in [F]. C in [F]/[m] is same b/c length is 1 m.

% Convert total inductance to inductance per element.
dL1 = 0.0001/(N/2); 
dC1 = 1e-6/(N/2);
%L1 = 0.0001/N;
%C1 = 1e-6/N;
Z01 = sqrt(dL1/dC1);

dL2 = 4*dL1;
dC2 = dC1;
w = 1e6;
Z02 = sqrt(dL2/dC2);

Z = zeros(1, N);
Z(end) = 2*sqrt(dL2/dC2);

V(1) = 1.0;

L = dL1;
C = dC1;
for n = [N:-1:2]
    if n > N/2
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
for n = [1:N-1]
    if n > N/2
        L = dL2;
        C = dC2;
    else
        L = dL1;
        C = dC1;
    end
    I(n+1) = I(n) - 1j*w*C*V(n);
    V(n+1) = V(n) - 1j*w*L*I(n+1);
end

l1 = 1;
l2 = 1;
beta1 = w*sqrt(L1o*C1o);
beta2 = w*sqrt(L2o*C2o);
lambda1 = 2*pi/beta1;
lambda2 = 2*pi/beta2;

rho2 = (Z(end)/Z02 - 1)/(Z(end)/Z02 + 1);

rho2r = rho2*exp(-2j*beta2*l2); % rho2 rotated
z = (Z02/Z01)*(1 + rho2r)/(1 - rho2r);
rho1 = exp(2j*beta1*l2)*(z - 1)/(z + 1);

xe = (l1+l2)*([0:N-1]/(N-1) - 1);

Vs = 1;
x1 = xe(xe < -l1);
V1p = Vs/ (exp( 1j*beta1*(l1+l2)) + rho1*exp(-1j*beta1*(l1+l2)));
V1  = V1p*(exp(-1j*beta1*x1)      + rho1*exp( 1j*beta1*x1));

x2  = xe(xe >= -l1);
V2p = V1p*(exp(1j*beta1*l2) + rho1*exp(-1j*beta1*l2)) ...
         /(exp(1j*beta2*l2) + rho2*exp(-1j*beta2*l2));
V2  = V2p*(exp(-1j*beta2*x2) + rho2*exp(1j*beta2*x2));

Ve = [V1, V2]; % Exact
Va = V;        % TL approximation

titlestr = sprintf(['N = %d; \\rho_1=%.3f + %.3fj; \\rho_2=%.3f + %.3fj;',...
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

print('final.svg', '-dsvg');
print('final.png', '-dpng', '-r300'); 

p = get(gcf,'Position');
orient tall
set(gcf,'PaperSize',[8.5,8])
print('final.pdf', '-dpdf');
