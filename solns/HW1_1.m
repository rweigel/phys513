clear;

% Write algorithm for single N and compare with hand calculation
N = 3;
S3 = (1/3)*(1 + 2/2^(3/2)); % Test case worked out by hand

% Also checked with 
% N = 5;
% S5 = (1/5)*(1 + 2/(1+0.5^2)^(3/2) + 2/2^(3/2));

iinit  = -(N-1)/2;
ifinal =  (N-1)/2;
delta  = 2/(N-1);

S = 0;
for i = iinit:ifinal
    S = S + (1/N)/(1+(i*delta)^2)^(3/2);
end

if N == 3
    fprintf('N=3 (sum from code) - (sum by hand): %.16f\n',S3-S);
    % N=3 (sum from code) - (sum by hand): 0.0000000000000000
end
if N == 5
    fprintf('N=5 (sum from code) - (sum by hand): %.16f\n',S5-S);
    % N=5 (sum from code) - (sum by hand): 0.0000000000000000
end

% Algorithm for arbitrary positive and odd N

k = 0;
for N = 3:2:100
    k = k + 1;
    iinit  = -(N-1)/2;
    ifinal =  (N-1)/2;
    delta = 2/(N-1);
    n(k) = N;
    S(k) = 0;
    for i = iinit:ifinal
        S(k) = S(k) + 1/(1+(i*delta)^2)^(3/2);
    end
    S(k) = S(k)/N;
end

Err = abs(1-sqrt(2)*S);

figure(1);clf
    % Check that sum is converging to a constant value
    plot(n,S,'.','MarkerSize',20);
    xlabel('N');
    ylabel('S [dimensionless]');
    grid on;

print -dpng -r300 HW1_1a.png
print -dsvg HW1_1a.svg

figure(2);clf;
    % Plot error vs. N. Plot should be monotonically decreasing (until
    % errors in precision become significant).
    loglog(n,Err,'.','MarkerSize',20);
    xlabel('N');
    ylabel('Error [dimensionless]');
    hold on;
    plot([3,n(end)],[0.01,0.01],'k-');
    grid on;

% Find first index where abs(Err) < 0.01
I = find(Err < 0.01, 1);
fprintf('|Error| < 0.01 when N >= %d\n',n(I));
% |Error| < 0.01 when N >= 51

print -dpng -r300 HW1_1b.png
print('-dsvg','BackgroundColor','none','HW1_1b.svg')

