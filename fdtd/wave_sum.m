Nx = 300;
x = [1:Nx];
lambda = 100;
rho = 0.5;
phase = 0;
show_sum = 1;
show_sum_past = 1;
nframes = 300;

fname = 'traveling_waves-show_phase_%02d-sum_%d-past_%d-rho_%.2f.mp4';
fname = sprintf(fname,phase,show_sum,show_sum_past,rho);

vidfile = VideoWriter(fname,'MPEG-4');
open(vidfile);
figure(1);clf
for i = 1:nframes
    Ei = cos(2*pi*(x-i)/lambda);
    % Set values to right of wave front to NaN so they won't be plotted.
    Ei(i+1:end) = NaN; 

    Er = cos(2*pi*(x-i)/lambda + 2*pi*phase/180);
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
    
    if i == 1
        ts = sprintf('$\\phi=%d^\\circ$ ; $\\rho=%.2f$',phase,rho);
        title(ts,'Interpreter','LaTeX','FontWeight','normal')
        vplus = '$V^+=\cos(\omega t + 2\pi x/\lambda + \phi)$';
        vminus = '$V^-=\rho\cos(\omega t - 2\pi x/\lambda + \phi)$';
        vsum = '$V^++V^-$';
        set(gcf,'defaultLegendAutoUpdate','off')
        l1 = legend(vplus,vminus,'Orientation', 'Horizontal','Interpreter','LaTeX');
    end
    
    set(gca,'Ylim',[-2,2]);
    %grid off;
    box on;
    set(gca,'XTickLabels','');
    set(gca,'YTickLabels','');
    grid on;
    set(gca,'Xlim',[1,Nx]);
    if mod(i,100) == 0
        % Allow early termination of animation
        %input('Continue?');
    end
    drawnow;
    frame = getframe(gcf); 
    writeVideo(vidfile,frame);    
end
close(vidfile)
