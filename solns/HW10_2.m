clear

set(0,'DefaultAxesFontName','Times');
set(0,'DefaultAxesTitleFontWeight','normal');
set(0,'DefaultTextFontName','Times');
set(0,'DefaultTextFontSize',16);
set(0,'DefaultAxesFontSize',16);
set(0,'defaultTextInterpreter','LaTeX')

opts = 1;

if opts == 1
    N = 101;
    L = 1;
    C = 1;
    w = 1;
    ts = '$Z_l=Z_o$';
    Zo = sqrt(L/C);
    ZL = Zo;
end

if opts == 2
    N = 101;
    L = 1;
    C = 1;
    w = 1;
    Zo = sqrt(L/C);
    ts = '$Z_l=10Z_o$';
    ZL = 10*Zo;
end

if opts == 3
    N = 101;
    L = 1;
    C = 1;
    w = 1;
    Zo = sqrt(L/C);
    ts = '$Z_l=0$';
    ZL = 0;
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

figure(1);clf
subplot(2,1,1);grid on;hold on;
title(ts)
plot([0:N-1],abs(V),'k','LineWidth',2);hold on;
xlabel('$n$')
ylabel('$|\widetilde{V}|$ [V]');
subplot(2,1,2);grid on;hold on;
plot([0:N-1],(180/pi)*angle(V),'k','LineWidth',2);hold on;
ylabel('$\angle\mbox{ }\widetilde{V}\mbox{ [degrees]}$');
xlabel('$n$')
set(gca,'YLim',[-180, 180])
set(gca,'YTick',[-180:60:180])

fname = sprintf('HW10_2_%d',opts);
print(sprintf('%s.svg',fname), '-dsvg');
print(sprintf('%s.png',fname), '-dpng', '-r300'); 

p = get(gcf,'Position');
orient tall
set(gcf,'PaperSize',[8.5,8])
print(sprintf('%s.pdf',fname), '-dpdf');
