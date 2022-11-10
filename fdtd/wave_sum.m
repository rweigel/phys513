Nx = 300;
x = [1:Nx];
lambda = 100;
rho = 0.5;

if 1
figure(1);clf
for i = 1:300
    Ei = cos(2*pi*(x-i)/lambda);
    % Set values to right of wave front to NaN so they won't be plotted.
    Ei(i+1:end) = NaN; 
    Er = rho*fliplr(Ei);
    
    % Plot current time step as light grey.
    % Keep past time steps
    hold on;
    grid on;
    plot(Ei,'k','LineWidth',1,'Color',[1,1,1,0.4]/2);
    plot(Er,'k','LineWidth',1,'Color',[1,1,1,0.4]/2);    
    if i > 1
        % Delete previous current time step thick black line
        delete(h1)
        delete(h2)
    end
    % Plot current time step as thick black line
    h1 = plot(Ei,'k','LineWidth',2);
    h2 = plot(Er,'k','LineWidth',2);
    
    set(gca,'Ylim',[-2,2]);
    set(gca,'Xlim',[1,Nx]);
    %legend('V^{+}');
    % Uncomment the following to hide past time steps
    %hold off;
    if mod(i,100) == 0
        % Allow early termination of animation
        input('Continue?');
    end
    drawnow;
end
end

if 0
figure(1);clf
for i = 1:500
    Ei = cos(2*pi*(x-i)/lambda);
    % Set values to right of wave front to NaN so they won't be plotted.
    Ei(i+1:end) = NaN; 
    Er = rho*fliplr(Ei);
    Et = Ei + Er;

    % Plot current time step as light grey.
    % Keep past time steps
    hold on;
    grid on;
    plot(Et,'k','LineWidth',1,'Color',[1,1,1,0.4]/2);
    if i > 1
        % Delete previous current time step thick black line
        delete(h1)
    end
    % Plot current time step as thick black line
    h1 = plot(Et,'k','LineWidth',2);
    
    set(gca,'Ylim',[-2,2]);
    set(gca,'Xlim',[1,Nx]);
    %legend('V^{+}');
    % Uncomment the following to hide past time steps
    %hold off;
    if mod(i,100) == 0
        % Allow early termination of animation
        input('Continue?');
    end
    drawnow;
end
end