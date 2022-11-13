Nx = 300;
x = [1:Nx];
lambda = 100;
rho = 1;


if 1
vidfile = VideoWriter('wave_sum_1_rho_1.0.mp4','MPEG-4');
open(vidfile);
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
    plot(Ei,'r','LineWidth',1,'Color',[1,1,1,0.4]/2);
    plot(Er,'b','LineWidth',1,'Color',[1,1,1,0.4]/2);    
    if i > 1
        % Delete previous current time step thick black line
        delete(h1)
        delete(h2)
    end
    % Plot current time step as thick black line
    h1 = plot(Ei,'r','LineWidth',2);
    h2 = plot(Er,'b','LineWidth',2);
    
    set(gca,'Ylim',[-2,2]);
    set(gca,'Xlim',[1,Nx]);
    %legend('V^{+}');
    % Uncomment the following to hide past time steps
    %hold off;
    if mod(i,100) == 0
        % Allow early termination of animation
        %input('Continue?');
    end
    drawnow;
    frame = getframe(gcf); 
    writeVideo(vidfile,frame);    

end
close(vidfile)
end

if 0
vidfile = VideoWriter('wave_sum_2_rho_1.mp4','MPEG-4');
open(vidfile);
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
        delete(h2)
        delete(h3)
    end
    % Plot current time step as thick black line
    h1 = plot(Ei,'r','LineWidth',2);
    h2 = plot(Er,'b','LineWidth',2);
    h3 = plot(Et,'k','LineWidth',2);
    
    set(gca,'Ylim',[-2,2]);
    set(gca,'Xlim',[1,Nx]);
    %legend('V^{+}');
    % Uncomment the following to hide past time steps
    %hold off;
    if mod(i,100) == 0
        % Allow early termination of animation
        %input('Continue?');
    end
    drawnow;
    frame = getframe(gcf); 
    writeVideo(vidfile,frame);    
end
close(vidfile)
end