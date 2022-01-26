function setupPlot(wave,mic,lspkr,S,R,n,spacing,dim,dispWave)
    if(dim == 2)
        figure;
        if(dispWave == 1)
            xImage = -n:spacing:n;   % The x data for the image corners
            yImage = -n:spacing:n;             % The y data for the image corners
            imagesc(xImage, yImage,abs(imag(wave))); colorbar;
            xlabel("Distance in [m]"); ylabel("Distance in [m]");
            hold on;
        end
        % Draw circle
        angles = linspace(0, 2*pi, 500);
        radius = R;
        CenterX = 0; CenterY = 0;
        x = radius * cos(angles) + CenterX;
        y = radius * sin(angles) + CenterY;
        plot(x, y, 'r--', 'LineWidth', 2);
        
        hold on;
        plot(-lspkr(1,:),-lspkr(2,:),'ko','MarkerSize',10,'MarkerFaceColor','b');
        plot(S(1),S(2),'h','MarkerSize',10,'MarkerFaceColor','magenta');
        
        title("ANC System Setup");
    

    elseif(dim == 3)
        figure;
        plot3(mic(1,:),mic(2,:),mic(3,:),'ko','MarkerSize',10,'MarkerFaceColor','k');
        hold on;
        plot3(lspkr(1,:),lspkr(2,:),lspkr(3,:),'ko','MarkerSize',10,'MarkerFaceColor','b');
        plot3(S(1),S(2),S(3),'h','MarkerSize',10,'MarkerFaceColor','magenta');

        zlim([-n n])
        title("ANC System Setup");
        if(dispWave == 1)
            hold on;
            xImage = [-n -n; n n];   % The x data for the image corners
            yImage = [n -n; n -n];             % The y data for the image corners
            zImage = [0 0; 0 0];% The z data for the image corners
            surf(xImage,yImage,zImage,...    % Plot the surface
                 'CData',imag(wave),...
                 'FaceColor','texturemap');
            axis tight;
           zlim([-n n]);
        end
        hold off;
    end
    
   

end