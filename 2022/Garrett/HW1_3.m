%% PHYS 513 HW1 Problem 1.3
% Draw the field lines for equal and opposite point charges located at
% (d,0,0) and (-d,0,0). The particles have a charge of q.

% t is the parameter used in solving x(t) and y(t) using obe45.
% t found through trial and error.
t = [0 5];

% Create skeletons to store initial conditions.
ypos = zeros(2,16);
yneg = zeros(2,16);
d = 1;
theta = 0;
delta = 0.01;
% Initalize 16 starting points for each the positive and negative point
% charge. This approach has 16 starting points equally spaced along the
% unit circle of radius delta.
for i=1:1:16
    ypos(1,i) = d + delta*sin(theta);
    ypos(2,i) = delta*cos(theta);
    yneg(1,i) = -d + delta*sin(theta);
    yneg(2,i) = delta*cos(theta);
    theta = theta + pi/8;
end

% Now calculate and plot the field lines.
figure;
hold on;
grid on;
axis([-5 5 -5 5]);
for i=1:1:16
    [~,y] = ode45(@dsdt_fun,t,ypos(:,i));
    plot(y(:,1),y(:,2),'b');
    [~,y] = ode45(@neg_dsdt_fun,t,yneg(:,i));
    plot(y(:,1),y(:,2),'b');
end
title("Electric Dipole Field Lines");
xlabel("x, []");
ylabel("y, []");

%% Functions
% Original dsdt was based on partial derivatives, which did not work likely
% due to error in calculation or transcription.
%{
function dsdt = negodefun(t,y)
    d = 1;
    dsdt = zeros(2,1);
    dsdt(1,1) = -(((y(1)+d)^2+y(2)^2)^(3/2)-(y(1)+d)*3/2*((y(1)+d)^2+y(2)^2)^(1/2)*(2*(y(1)+d)))/((y(1)+d)^2+y(2)^2)^3 + ...
        (((y(1)-d)^2+y(2)^2)^(3/2)-(y(1)-d)*3/2*((y(1)-d)^2+y(2)^2)^(1/2)*2*(y(1)-d))/((y(1)-d)^2+y(2)^2)^3;
    dsdt(2,1) = -(((y(1)+d)^2+y(2)^2)^(3/2)-y(2)*3/2*((y(1)+d)^2+y(2)^2)^(1/2)*2*y(2))/((y(1)+d)^2+y(2)^2)^3 + ...
        (((y(1)-d)^2+y(2)^2)^(3/2)-y(2)*3/2*((y(1)+d)^2+y(2)^2)^(1/2)*2*y(2))/((y(1)-d)^2+y(2)^2)^3;
end

function dsdt = odefun(t,y)
    d = 1;
    dsdt = zeros(2,1);
    dsdt(1,1) = (((y(1)+d)^2+y(2)^2)^(3/2)-(y(1)+d)*3/2*((y(1)+d)^2+y(2)^2)^(1/2)*(2*(y(1)+d)))/((y(1)+d)^2+y(2)^2)^3 - ...
        (((y(1)-d)^2+y(2)^2)^(3/2)-(y(1)-d)*3/2*((y(1)-d)^2+y(2)^2)^(1/2)*2*(y(1)-d))/((y(1)-d)^2+y(2)^2)^3;
    dsdt(2,1) = (((y(1)+d)^2+y(2)^2)^(3/2)-y(2)*3/2*((y(1)+d)^2+y(2)^2)^(1/2)*2*y(2))/((y(1)+d)^2+y(2)^2)^3 - ...
        (((y(1)-d)^2+y(2)^2)^(3/2)-y(2)*3/2*((y(1)+d)^2+y(2)^2)^(1/2)*2*y(2))/((y(1)-d)^2+y(2)^2)^3;
end
%}

function fx = fxfun(t,y)
    d = 1;
    fx = -(y(1)+d)/((y(1)+d)^2+y(2)^2)^(3/2)+(y(1)-d)/((y(1)-d)^2+y(2)^2)^(3/2);    
end

function fy = fyfun(t,y)
    d = 1;
    fy = -y(2)/((y(1)+d)^2+y(2)^2)^(3/2) + y(2)/((y(1)-d)^2+y(2)^2)^(3/2);
end

function f = f_fun(t,fx,fy)
    f = sqrt(fx^2+fy^2);
end

function dsdt = dsdt_fun(t,y)
    dsdt = zeros(2,1);
    fx = fxfun(t,y);
    fy = fyfun(t,y);
    f = f_fun(t,fx,fy);
    dsdt(1) = fx/f;
    dsdt(2) = fy/f;
end

function dsdt = neg_dsdt_fun(t,y)
    dsdt = zeros(2,1);
    fx = -fxfun(t,y);
    fy = -fyfun(t,y);
    f = f_fun(t,fx,fy);
    dsdt(1) = fx/f;
    dsdt(2) = fy/f;
end
