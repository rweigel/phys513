clear

Vs = 1;
lambda1 = 10e-3;
lambda2 = 5e-3;
Z1 = 1;
Z2 = Z1/2;
Z3 = Z1/3;

l1 = lambda1;
l2 = (3/4)*lambda2;

beta1 = 2*pi/lambda1;
beta2 = 2*pi/lambda2;

rho2 = (Z3-Z2)/(Z3+Z2);

rho2r = rho2*exp(-2j*beta2*l2); % rho2 rotated
z     = (Z2/Z1)*(1 + rho2r)/(1 - rho2r);
rho1  = exp(2j*beta1*l2)*(z - 1)/(z + 1);

V1p = Vs/(exp(1j*beta1*(l1+l2)) + rho1*exp(-1j*beta1*(l1+l2)));
V2p = V1p*(exp(1j*beta1*l2) + rho1*exp(-1j*beta1*l2)) / ...
          (exp(1j*beta2*l2) + rho2*exp(-1j*beta2*l2));

x1 = [-(l1+l2):0.1e-3:-l2];
V1 = V1p*(exp(-1j*beta1*x1) + rho1*exp(1j*beta1*x1));
x2 = [-l2:0.1e-3:0];
V2 = V2p*(exp(-1j*beta2*x2) + rho2*exp(1j*beta2*x2));

clf;hold on; grid on;
plot(x1/1e-3, abs(V1),'k','LineWidth',2)
plot(x2/1e-3, abs(V2),'k','LineWidth',2)
plot([0, 5], [abs(V2(end)),abs(V2(end))],'k','LineWidth',2)
text(5.5, abs(V2(end)),'...')
legend('$|\widetilde{V}(x)|/|\widetilde{V}_s|$','Autoupdate','off','Interpreter','LaTeX')
xlabel('x [cm]')

VSWR1 = (1+abs(rho1))/(1-abs(rho1));
VSWR2 = (1+abs(rho2))/(1-abs(rho2));
VSWR3 = 1;
title(sprintf('VSWR_1 = %.2f; VSWR_2 = %.2f; VSWR_3 = %d',VSWR1,VSWR2,VSWR3));

box on;
set(gca, 'XLim', [x1(1)/1e-3, 6])
ylims = get(gca,'YLim');
p = patch([x1(1), x1(end), x1(end), x1(1)]/1e-3,[ylims(1), ylims(1), ylims(2), ylims(2)],'k');
set(p,'FaceAlpha',0.5,'EdgeColor','none');
set(gca,'YLim',ylims)
p = patch([x2(1), x2(end), x2(end), x2(1)]/1e-3,[ylims(1), ylims(1), ylims(2), ylims(2)],'k');
set(p,'FaceAlpha',0.2,'EdgeColor','none');
set(gca,'YLim',ylims)
p = patch([0, 6, 6, 0],[ylims(1), ylims(1), ylims(2), ylims(2)],'k');
set(p,'FaceAlpha',0.1,'EdgeColor','none');
set(gca,'YLim',ylims)

print('HW11.svg', '-dsvg');
print('HW11.png', '-dpng', '-r300'); 
