clear;

method = 1; % method = 2 to use Forward Euler
methods = {'ODE45','Forward Euler'}; % For plot title

% Initial position
xo = 1;
yo = 1;

% Length of field line is sspan(2)-sspan(1). (Only difference matters
% here.)
sspan= [0, 3];
% sspan(2)-sspan(1) should be close to
% sum(sqrt((xy(1:end-1,1)-xy(2:end,1)).^2+(xy(1:end-1,2)-xy(2:end,2)).^2),2)

if method == 1
    % Using MATLAB's ODE45 function
    [s, xy] = ode45(@fun1, sspan, [xo, yo]) ;
else
    %% Forward Euler
    ds = 0.01;
    
    s = 0;
    xy = [xo,yo];
    
    %fprintf('t\tx\ty\n')
    i = 1;
    while s < sspan(2)
        %fprintf('%.1f\t%.1f\t%.1f\n',t(i),x(i),y(i));
        [Ex, Ey] = field(xy(i,1),xy(i,2));
        E = sqrt(Ex^2+Ey^2);
        xy(i+1,1) = xy(i,1) + ds*Ex/E;
        xy(i+1,2) = xy(i,2) + ds*Ey/E;
        s(i+1) = s(i) + ds;
        i = i + 1;
    end
end

clf;
plot(xy(:,1),xy(:,2))
hold on;
title(sprintf('Field line for dipole using %s',methods{method}));
axis square
plot(1,0,'.','Color','red','MarkerSize',20)
plot(-1,0,'.','Color','blue','MarkerSize',20)
grid on;
xlabel('x/d');
ylabel('y/d');

% Label initial position
plot(xo,yo,'o')
text(xo+0.1,yo,'Initial Position')

set(gca,'XLim',[-2,2])
set(gca,'YLim',[-2,2])

fprintf('Printing\n');
print -dpng HW2_1.png
print -dpdf HW2_1.pdf
print -dsvg HW2_1.svg

function [Ex, Ey] = field(x,y)
    Ex = 0;
    Ey = 0;
    P = [-1, 0; 1, 0];
    Q = [-1, 1];
    for i = 1:size(P,1)
        Ex(i) = Q(i)*(x-P(i,1))/(((x-P(i,1))^2+(y-P(i,2))^2)^(3/2));
        Ey(i) = Q(i)*(y-P(i,2))/(((x-P(i,1))^2+(y-P(i,2))^2)^(3/2));
    end
    Ex = sum(Ex);
    Ey = sum(Ey);
end

function dXds = fun1(s,X)
    
    [Fx, Fy] = field(X(1),X(2));
    F = sqrt(Fx^2 + Fy^2);
    dXds(1,1) = Fx/F;
    dXds(2,1) = Fy/F;
end

