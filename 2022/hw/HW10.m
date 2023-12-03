clear

set(0,'DefaultAxesFontName','Times');
set(0,'DefaultAxesTitleFontWeight','normal');
set(0,'DefaultTextFontName','Times');
set(0,'DefaultTextFontSize',16);
set(0,'DefaultAxesFontSize',16);

run = 1;

if run == 1
    % Problem 9.2 - check of code result with hand calculation
    N = 3;
    L = 1;
    C = 1;
    w = 1;
    Zo = sqrt(L/C);
    ZL = Zo;
end

if run == 2
    % Perfectly matched (10.2)
    N = 101;
    Lo = 0.0001;
    Co = 1e-6;
    L = Lo/N;
    C = Co/N;
    w = 1e6;
    Zo = sqrt(L/C);
    ZL = Zo;
    fname = 'HW10_2_perfectly_matched';
end

if run == 3
    % Not perfectly matched (problem 10.5)
    N = 101;
    Lo = 0.0001;
    Co = 1e-6;
    L = Lo/N;
    C = Co/N;
    w = 1e6;
    Zo = sqrt(L/C);
    ZL = 3*Zo;
    fname = 'HW10_2_not_perfectly_matched';
end

Z = zeros(1, N);
Z(end) = ZL;

V(1) = 1.0; % Source voltage

% Compute impedances starting at load
for n = [N:-1:2]
    y = 1/(Z(n) + 1j*w*L);
    Z(n-1) = 1/(y + 1j*w*C);
end

I(1) = V(1)/Z(1);
for n = [1:N-1]
    I(n+1) = I(n) - 1j*w*C*V(n);
    V(n+1) = V(n) - 1j*w*L*I(n+1);        
end

if run == 1
    Z
    V
    I
else
    clf;
    plot([0:N-1],abs(V),'r','LineWidth',2);hold on;
    plot([0:N-1],abs(I),'b','LineWidth',2);
    plot([0:N-1],abs(Z)/Z(end),'g','LineWidth',2);
    grid on;
    xlabel('$n$','Interpreter','Latex')
    legend('$|\widetilde{V}|$ [V]','$|\widetilde{I}|$ [A]','$|Z|/Z_L$','Interpreter','Latex','Orientation','Horizontal')
    title(sprintf('L_o = %.1f [mH], C_o = %.1f [\\muF], Z_L/Z_o = %.1f, VSWR = %.1f',Lo*1000, Co*1e6, Z(end)/Zo, max(abs(V))/min(abs(V))));
    
    print([fname,'.pdf'],'-dpdf','-bestfit')
    print([fname,'.png'],'-dpng')    
end