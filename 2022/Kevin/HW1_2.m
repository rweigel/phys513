%Kevin Arellano-Moya
%Homework 1 Problem 1.2
%%
%Integration
clc;
clear;
close all;

syms K Q L x y
dEy = ((K*Q)/(2*L)) * (y)/((x^2 + y^2)^(3/2));
dEx = ((K*Q)/(2*L)) * (x)/((x^2 + y^2)^(3/2));

Ey = int(dEy,x);

Ex = int(dEx,x);
%% 
%Ey approximation

e0 = 8.854e-12;
K = 1/(4*pi*e0);
L = 100; %arbitruary values for L and Lambda0 were chosen
lambda0 = 1;

Eye = (2*K*lambda0)/(sqrt(2)*L);

for i = 1:15
    n = 2*i + 1;
    Eyanew = 0;
    for j = 1:n
        Eya0 = ((K*lambda0*2*L) / (2*n + 1)) * ((2*L)/(((L/n)^2) * ...
            j^2 + L^2)^(3/2));

        Eyanew = Eyanew + Eya0;
    end
    
    Eya = Eyanew + ((K*lambda0*2*(L/(2*n+1)))*(1/L^2));
    error = abs((Eye - Eya)/Eye);
        
    if error < 0.01
        n = n
        break  
    end
 end

fprintf('error = %f',error)


   


    
   
