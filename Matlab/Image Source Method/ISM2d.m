function wave = ISM2d(rx,ry,rz,S,L,mag,phase,omega,c,alpha,order,spacing,visualize) 
    wave = zeros(L(2)/spacing+1,L(1)/spacing+1);
    nx = L(1); ny=L(2); nz = L(3);
    [rho_s,the_s,phi_s] = my_cart2sph(S);
    parfor idy=1:ny/spacing+1
        wavex = zeros(1,nx/spacing+1);
        for idx=1:nx/spacing+1
            [rho_r,the_r,phi_r] = my_cart2sph([rx(idx);ry(idy);rz(1)]);
            wavex(idx) = ISMspherical(rho_s,the_s,phi_s,rho_r,the_r,phi_r,L,mag,phase,omega,c,alpha,order);
            %ISM(S,[x,y,nz/2],L,mag,phase,omega,c,alpha,order,spacing);
        end 
        wave(idy,:) = wavex;
    end
    
    if(visualize == 1)
        imagesc(ry,rx,imag(wave));
        xlabel("Distance in [m]");
        ylabel("Distance in [m]");
        title("Point Source wave - Image Source Method");
        colorbar;
    end
end