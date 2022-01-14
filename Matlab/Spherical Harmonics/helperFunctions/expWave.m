function wave = expWave(sz,r,k,dim,plotting)
    wave = zeros(sz);
    for idy = 1:sz(1)
        for idx = 1:sz(2)
            wave(idy,idx) = exp(1i.*dot([r(1,idx);r(2,idy);r(3,1)],k,1));
        end
    end
    if(plotting == 1)   
        if(dim == 0)
            % No plot;
        elseif(dim == 1)
            plot(r(1,:),imag(wave));
            xlabel("Distance in [m]");
            ylabel("Pressure in [Pa]");
            title("Plane wave in 1D");
        elseif(dim == 2)
            imagesc(r(1,:),r(2,:),imag(wave));
            xlabel("Distance in [m]");
            ylabel("Distance in [m]");
            
            title("Plane wave");
            colorbar;
        else
            sprintf("ERROR: Only 0 , 1 and 2 Dimensions possible")
        end
    end
end