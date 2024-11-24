clear

set(0,'DefaultAxesFontName','Times');
set(0,'DefaultAxesTitleFontWeight','normal');
set(0,'DefaultTextFontName','Times');
set(0,'DefaultTextFontSize',16);
set(0,'DefaultAxesFontSize',16);

opts = 2;

if opts == 1
    N = 3;
    L = 1;
    C = 1;
    w = 1;
    Zo = sqrt(L/C);
    ZL = Zo;
end

if opts == 2
    N = 101;
    L = 1;
    C = 1;
    w = 1;
    Zo = 10*sqrt(L/C);
    ZL = Zo;
end

if opts == 3
    N = 101;
    L = 1;
    C = 1;
    w = 1;
    Zo = 10*sqrt(L/C);
    ZL = 0;
end

if opts == 4
    % Perfectly matched
    N = 101;
    Lo = 0.0001;
    Co = 1e-6;
    L = Lo/N;
    C = Co/N;
    w = 1e6;
    Zo = sqrt(L/C);
    ZL = Zo;
end

if opts == 5
    % Not perfectly matched (problem 10.5)
    N = 101;
    Lo = 0.0001;
    Co = 1e-6;
    L = Lo/N;
    C = Co/N;
    w = 1e6;
    Zo = sqrt(L/C);
    ZL = 3*Zo;
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

if N == 3
    Z
    V
    I
%Z = 0.5000 - 0.5000i   1.0000 - 1.0000i   1.0000 + 0.0000i
%V = 1.0000 + 0.0000i   1.0000 - 1.0000i   0.0000 - 1.0000i
%I = 1.0000 + 1.0000i   1.0000 + 0.0000i   0.0000 - 1.0000i
end

clf;
plot([0:N-1],abs(V),'r','LineWidth',2);hold on;
plot([0:N-1],abs(I),'b','LineWidth',2);
plot([0:N-1],abs(Z)/Z(end),'g','LineWidth',2);
grid on;
xlabel('$n$','Interpreter','Latex')
legend('$|\widetilde{V}|$ [V]','$|\widetilde{I}|$ [A]','$|Z|/Z_L$','Interpreter','Latex','Orientation','Horizontal')