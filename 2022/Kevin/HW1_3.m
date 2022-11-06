%Kevin Arellano-Moya
%Homework 1 Problem 3

clc;
clear;
close all;

%% Euler's Method

 dt = 0.01;
    t = 0;
    x(1) = 1;
    y(1) = 1;
    z(1) = 1;
    d = 2
    Nsteps = 100;

    fprintf('t\tx\ty\n')

    for i = 1:Nsteps-1
        fprintf('%.1f\t%.1f\t%.1f\n',t(i),x(i),y(i),z(i));
        x(i+1) = x(i) + dt*((x(i) - d) / ((x(i) - d) + y(i) + z(i)));
        y(i+1) = y(i) + dt*((y(i)) / ((x(i) - d) + y(i) + z(i)));
        z(i+1) = z(i) + dt*((z(i)) / ((x(i) - d) + y(i) + z(i)));
        t(i+1) = t(i) + dt;
        
    end
    
    plot(x,y)
    hold on;
    xlabel('x')
    ylabel('y')
    title('$dx/dt=Ex/E; dy/dt=Ey/E$; x(0)=y(0)=1','Interpreter','Latex');
    
   