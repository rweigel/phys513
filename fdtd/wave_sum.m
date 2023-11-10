Nx = 300;
x = [1:Nx];
lambda = 100;
rho = 0.5;
phase = 0;
show_sum = 1;
show_sum_past = 1;

fname = sprintf('traveling_waves-show_sum_%d-show_sum_past-%d-rho_%.2f.mp4',...
                show_sum,show_sum_past,rho);
vidfile = VideoWriter(fname,'MPEG-4');
open(vidfile);
figure(1);clf
for i = 1:500
    Ei = cos(2*pi*(x-i)/lambda);
    % Set values to right of wave front to NaN so they won't be plotted.
    Ei(i+1:end) = NaN; 

    Er = cos(2*pi*(x-i)/lambda + phase);
    Er(i+1:end) = NaN; 
    Er = rho*fliplr(Er);

    if show_sum
        Et = Ei + Er;
    end

    hold on;grid on;
    if show_sum && show_sum_past
        % Plot past as think black line
        plot(Et,'k','LineWidth',1,'Color',[1,1,1,0.4]/2);
    end

    if i > 1
        % Delete previous and current time step thick lines
        delete(h1)
        delete(h2)
        if show_sum
            delete(h3)
        end
    end

    % Plot current time step as thick line
    h1 = plot(Ei,'r','LineWidth',2);
    h2 = plot(Er,'b','LineWidth',2);
    if show_sum
        h3 = plot(Et,'k','LineWidth',2);
    end
    
    set(gca,'Ylim',[-2,2]);
    %grid off;
    box on;
    set(gca,'XTickLabels','');
    set(gca,'YTickLabels','');
    grid on;
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
