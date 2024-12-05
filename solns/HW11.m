clear
set(0,'defaultTextInterpreter','LaTeX')
set(0,'defaultLegendInterpreter','LaTeX');

T = 2*pi;

if 0
% Solution for one ladder step
figure(1);clf;hold on;grid on;
[t, X] = ode45(@dXdt1, [0, 5*pi], 0);
plot(t,cos(t),'k-','LineWidth',2);
plot(t,X(:,1),'r-','LineWidth',2);
title_ = '$dx/dt = -x + \cos(t)$';
title(title_,'FontWeight','bold');
legend('$\cos(t)$','$x$');
xlabel('$t$');
end

if 1
% Solution for two ladder steps
figure(2);clf;hold on;grid on;
[t, X] = ode45(@dXdt2, [0, 5*T], [0, 0, 0]);
title('Lines show exact soln.; dots are steady state soln.')
plot(t/T,X(:,1),'g-','LineWidth',4);
plot(t/T,X(:,2),'b-','LineWidth',4);
plot(t/T,X(:,3),'r-','LineWidth',4);
xlabel('$t/T$');

N = 3;
w = 2*pi/T;
L = 1;
C = 1;
R = 1;
Xss = ss(w,L,C,R,N); % I0, I1, I2, V0, V1, V2
Xss = Xss([2,3,5]);  %     I1, I2,     V1
for i = 1:size(Xss,2)
    xc = Xss(:,i);
    phi = atan(imag(xc)/real(xc));
    x(:,i) = abs(xc)*cos(w*t + phi);
end

plot(t/T,x(:,1),'k.','MarkerSize',10);
plot(t/T,x(:,2),'g.','MarkerSize',10);
plot(t/T,x(:,3),'b.','MarkerSize',10);
legend('$I_1$', '$I_2$', '$V_1$',...
        '$I_1^{\mbox{ss}}$', '$I_2^{\mbox{ss}}$', '$V_1^{\mbox{ss}}$');

% Alternative solution method. See notes.
A = [ 0  0 -1;...
      0 -1  1;...
      1 -1  0];
U = [-1 ; 0 ; 0];
for i = 1:size(A,2)
    A(i,i) = A(i,i)-1j*w;
end    
x = A\U
transpose(Xss)
end

print('HW11.svg', '-dsvg');
print('HW11.png', '-dpng', '-r300'); 

function X = ss(w,L,C,ZL,N)
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
    X = [I,V];
end

function ss_test(w,L,C,R,N)
    assert(N==4,'Only 4-step ladder tested');
    % Check ss() function
    % dX/dt = A*X + B.*U;
    % Sub X(t) = Xc*e^{jwt} where Xc is complex
    % U = e^{jwt}
    % 1j*w*Xc = A*Xc + B.*U;
    % A*Xc - 1j*w*Xc = -B
    % (A - diag(1j*w*Xc*ones(5,1)) = -B
    % Xc = A\(-B)
    A = [  0     0     0    -1/L   0;...
           0     0     0     1/L -1/L;...
           0     0   -R/L     0   1/L;...
          1/C  -1/C    0      0    0;...
           0    1/C  -1/C     0    0];
    for i = 1:size(A,2)
        A(i,i) = A(i,i)-1j*w;
    end
    B = [1 ; 0 ; 0 ; 0 ; 0];
    Xss_alt = A\(-B);
    Xss = ss(w,L,C,R,N);
    Xss = Xss([2,3,4,6,7]);
    assert(all(Xss_alt - transpose(Xss) < 2*eps+2*1j*eps))
end

function dXdt = dXdt1(t, X)
    T = 2*pi; % Note variable defined also above.
              % Better approach (not used here to keep code simple):
              % https://www.mathworks.com/matlabcentral/answers/168073-ode45-where-odefun-requires-more-parameters
    dXdt = -X + cos(2*pi*t/T);
end    

function dXdt = dXdt2(t, X)
    T = 2*pi;
    U = [cos(2*pi*t/T) ; 0 ; 0];    % Time-dependent drivers
    A = [ 0  0 -1;...
          0 -1  1;...
          1 -1  0];
    B = [1 ; 0 ; 0];
    dXdt = A*X + B.*U;
end
