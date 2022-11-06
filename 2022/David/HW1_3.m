

%Dear Dr. Weigel,
%This file contains my best attempts at solving 1.3. I know basically none
%of it works, but I hope you can gain at least some insight into what I was
%trying to do. I'm terribly sorry I couldn't complete it.
%Yours,
%David




X= [x;y];
step=[0:0.1:10];
d=1; %chosen arbitrarily
posloc = [d,0,0];
negloc = [-d,0,0];
R= 0.01 %chosen arbitrarily
%number of field lines to be created
ns=8;
%This creates the starting points for the field lines
for b = 1:ns
del_phi = 360/ns;

xipos = R*cos(del_phi*b)+d; %positive side of dipole,
xineg = R*cos(del_phi*b)-d; %negative side of dipole,
yi = R*sin(del_phi*b); %works for either side since the dipole rests on the y-axis

pospos = [xipos;yi];
negpos = [xineg;yi];
end




for k=1:8
[t,X] = ode45(@dxdtfun,step,pospos(:,k));
    plot(X(:,1),X(:,2));
end

for k=1:8
[t,X] = ode45(@dxdtfun,step,negpos(:,k));
    plot(X(:,1),X(:,2));
end

%function definitions:
%ex gives the component E_x
%ey gives the compnent E_Y
%exy is the pythagoras of the x and y components
%dxdt should implement the quotient E_x/E(x,y) and E_y/E(x,y)

% could do dxdt(1) = -(X(1)+d)/((X(1)+d)^2+X(2)^2)^(3/2)+(X(1)-d)/((X(1)-d)^2+X(2)^2)^(3/2)/sqrt((-(X(1)+d)/((X(1)+d)^2+X(2)^2)^(3/2)+(X(1)-d)/((X(1)-d)^2+X(2)^2)^(3/2))^2+(X(2)/((X(1)+d)^2+X(2)^2)^(3/2)+X(2)/((X(1)-d)^2+X(2)^2)^(3/2))^2);
%dxdt(2) = X(2)/((X(1)+d)^2+X(2)^2)^(3/2)+X(2)/((X(1)-d)^2+X(2)^2)^(3/2)/sqrt((-(X(1)+d)/((X(1)+d)^2+X(2)^2)^(3/2)+(X(1)-d)/((X(1)-d)^2+X(2)^2)^(3/2))^2+(X(2)/((X(1)+d)^2+X(2)^2)^(3/2)+X(2)/((X(1)-d)^2+X(2)^2)^(3/2))^2);
%? Don't know
function ex = exfun(step,X)
    d = 1;
    ex = -(X(1)+d)/((X(1)+d)^2+X(2)^2)^(3/2)+(X(1)-d)/((X(1)-d)^2+X(2)^2)^(3/2);
end

function ey = eyfun(step,X)
    d = 1;
    ey = X(2)/((X(1)+d)^2+X(2)^2)^(3/2)+X(2)/((X(1)-d)^2+X(2)^2)^(3/2);
end

function exy = exyfun (step,X)
 
    exy = sqrt(exfun^2+eyfun^2);

end

function dXdt = dxdtfun(step,X)

    dXdt = [exfun/exyfun;eyfun/exyfun];
end