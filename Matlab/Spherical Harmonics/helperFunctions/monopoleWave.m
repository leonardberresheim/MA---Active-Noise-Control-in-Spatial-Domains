function wave = monopoleWave(s,r,rho_k,visualize)
    wave = zeros(size(r,2),size(r,2));
    for idy = 1:size(r,2)
        for idx = 1:size(r,2)
            SRnorm = norm(s-[r(1,idx);r(2,idy);r(3,1)]);
            wave(idy,idx) = exp(1i*rho_k*SRnorm)/(4*pi*SRnorm); 
        end
    end
    if(visualize == 1)
        imagesc(imag(wave));
        xlabel("Distance in [m]");
        ylabel("Distance in [m]");
        title("Point Source wave");
        colorbar;
    end
    
end