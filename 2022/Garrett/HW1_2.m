%% PHYS 513 HW1 Problem 1.2
% Compute the number of equally spaced point charges required to
% approximate a line of distributed charge (with length 2L and charge distribution
% lambda) for the electric field at distance L perpendicular from the
% centerpoint of the line. 

% Initial number of nodes.
n = 3; 

error = inf;
fprintf('  n   relative error\n');
while (error > 0.01)
    sum = 0;
    for i=1:1:(n-1)/2
        sum = sum + OnePointContributionSymmetric(i,n);
    end
    
    % Don't forget the zeroth term, multiply by 2 to cancel the 1/2 later: 
    approximation = (4*sum + 2)/n;
    
    error = abs((sqrt(2) - approximation)/sqrt(2));
    fprintf('%3.0f   %3.4f\n',n,error);
    n = n + 2;
end

function [contribution] = OnePointContributionSymmetric(i,n)
    contribution = 1/((2*i/(n-1))^2+1)^(3/2);
end

%% Results
%{
Results from this program show that with 51 particles, the approximate
solution is within 1% of the exact solution.
This has a delta of:
delta = 2*L/(n-1) = L/25
%}