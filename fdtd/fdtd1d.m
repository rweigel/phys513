
% The following is a modified version of fdtd_original.m obtained from
% https://www.mathworks.com/matlabcentral/fileexchange/7459-fdtd1d-m
% The additions include the ability to extract the field at certain
% locations and to define different runs.
% To speed up the run, comment out the plotting in the loop.
% The basics of the algorithm when sigma = 0 is described in
% https://my.ece.utah.edu/~ece6340/LECTURES/lecture%2014/FDTD.pdf
% See also https://eecs.wsu.edu/~schneidj/ufdtd/ufdtd.pdf

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Scott Hudson, WSU Tri-Cities
%1D electromagnetic finite-difference time-domain (FDTD) program.
%Assumes Ey and Hz field components propagating in the x direction.
%Fields, permittivity, permeability, and conductivity
%are functions of x. Try changing the value of "profile".
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% RSW: Added annotations for plots and comments in code. Original code
% is fdtd1d_original.m.
set(0,'DefaultFigureWindowStyle','docked');
set(0,'DefaultAxesFontName','Times');
set(0,'DefaultAxesTitleFontWeight','normal');
set(0,'DefaultTextFontName','Times');
set(0,'DefaultTextFontSize',16);
set(0,'DefaultAxesFontSize',16);

% https://www.mathworks.com/matlabcentral/answers/338733-how-to-stop-legend-from-adding-data1-data2-when-additional-data-is-plotted
set(0,'DefaultLegendAutoUpdate','off');

%close all;
clear all;

animate = 1;

eps0 = 8.854e-12; % permittivity of free space
mu0  = pi*4e-7;   % permeability of free space
run = 1;

if run == 0
    profile = 0; % eps = eps_o, mu = mu_o, sigma = 0.
    source = 2;  % Gaussian pulse at left boundary
    xg = Lx;
    Niter = 600; % # of iterations to perform
end

if run == 1
    profile = 3;
    source  = 1;
    Lx  = 5;       % Domain length in meters
    Nx  = 500;     % Spatial samples in domain
    ixb = Nx/2;
    fs = 300e6;    % Source frequency in Hz
    fstr = '300 MHz';
    Niter = 400;   % Number of iterations to perform
    ip = ixb - 1;  % Index of probe
    ylims = [-3, 3];
end

ds = Lx/Nx; % spatial step in meters
dt = ds/fs; % "magic" time step
% See https://my.ece.utah.edu/~simpson/ECE5340/Taflove%20Chpt.%202.pdf
% for definition of magic time step.

% Scale factors for E and H
ae = ones(Nx,1)*dt/(ds*eps0);
am = ones(Nx,1)*dt/(ds*mu0);
as = ones(Nx,1);

% Create grid of epsilon, mu, sigma.
[epsr,mur,sigma] = fdtd_profile(profile, Nx, ixb);

figure(1);
fdtd_profile_plot(profile, Nx, ixb);
fstr = sprintf('figures/fdtd1d_run-%d_profile-%d.pdf', profile);
print(fstr, '-dpdf');

ae = ae./epsr;
am = am./mur;
ae = ae./(1+dt*(sigma./epsr)/(2*eps0));
as = (1-dt*(sigma./epsr)/(2*eps0))./(1+dt*(sigma./epsr)/(2*eps0));

% Initialize fields to zero
Hz = zeros(Nx,1);
Ey = zeros(Nx,1);

figure(2);clf
    set(gcf,'doublebuffer','on'); % For smoother graphics
    grid on;
    plot(Ey,'b','LineWidth',2);
    hold on;
    plot(377*Hz,'r','LineWidth',2);
    set(gca,'YLim',ylims); 

c = sqrt(1/eps0/mu0);
fprintf('-------------------------\n')
fprintf('Nx = %d\n',Nx);
fprintf('Lx = %.1f [m]\n',Lx);
fprintf('dx = Lx/Nx = %.1e [m]\n',ds);
fprintf('fs = %.1e [Hz]\n',fs);
fprintf('dt = ds/fs = %.1e [s]\n',dt);
fprintf('lamda   = %.2e [m]\n',c/fs/Lx);
fprintf('i_lamda = %.1f\n',Nx*c/fs/Lx);
fprintf('max(sigma)/(2*pi*f*epsilon_o) = %.1e\n',max(sigma)/(2*pi*fs*eps0));
fprintf('-------------------------\n')

for iter=1:Niter
    % Source
    if source == 1
        Ey(2) = sin(2*pi*fs*dt*iter);
    end
    if source == 2
        % Gaussian pulse
        Ey(3) = exp(-((iter-10)/5)^2);
    end
    
    % The next 10 or so lines of code are where we actually integrate Maxwell's
    % equations. All the rest of the program is basically bookkeeping and plotting.
    Hz(1) = Hz(2); % Absorbing boundary conditions for left-propagating waves
    for i=2:Nx-1 % Update H field
      Hz(i) = Hz(i)-am(i)*(Ey(i+1)-Ey(i));
    end
    Ey(Nx) = Ey(Nx-1); % Absorbing boundary conditions for right-propagating waves
    for i=2:Nx-1 % Update E field
      Ey(i) = as(i)*Ey(i)-ae(i)*(Hz(i)-Hz(i-1));
    end
    
    Hz_ip(iter) = Hz(ip);
    Ey_ip(iter) = Ey(ip);

    if (animate || iter == Niter)
        figure(2);hold off;
            plot(Ey,'b','LineWidth',2);
            hold on;
            grid on;
            plot(377*Hz,'r','LineWidth',2);
            title(sprintf('i_t = %03d; f = %s [Hz]; L_x = %.1f [m]',...
                iter,fstr,Lx));
            if animate && iter < Niter
                text(1,ylims(2),...
                    sprintf('E_y [V/m] (blue)\n377 H_z [T] (red)'),...
                    'VerticalAlignment','Top');
            else
                % Slows down rendering
                legend('E_y [V/m]','377H_z [T]') 
            end
            xlabel('i_x');
            fdtd1d_annotate;
            drawnow;
            %pause(0);
    end

    if iter == 1
        fprintf('i_t (Time Step) = %04d',iter);
    end
    if iter > 1
        fprintf('\b\b\b\b');
        fprintf('%04d',iter);
    end

end
fstr = sprintf('figures/fdtd1d_run-%d_profile-%d_vs_x_it-%d.pdf', run, profile, iter);
print(fstr, '-dpdf');

fprintf('\n');

figure(3);clf;
    plot(Ey_ip,'r','LineWidth',2);hold on;
    plot(377*Hz_ip,'b','LineWidth',2);
    xlabel('i_t');
    title(sprintf('At i_x = %d', ip))
    legend('E_y [V/m]','377H_z [T]', 'Location','NorthWest') 
    grid on;
    fstr = sprintf('figures/fdtd1d_run-%d_profile-%d_vs_t_ip-%d.pdf', run, profile, ip)
    print(fstr, '-dpdf')
    %fdtd1d_plot;
