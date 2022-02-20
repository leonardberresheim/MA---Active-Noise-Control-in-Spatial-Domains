function wave = ISM2d(rx,ry,rz,S,L,mag,phase,omega,c,alpha,order,spacing,visualize) 
%% AUTHOR    : Leonard Berresheim 
% ISM2d executes the ISM function for a 2-dimensional plane
%   wave = ISM2d(rx,ry,rz,S,L,mag,phase,omega,c,alpha,order,spacing,visualize) 
%   Eingabe 
%       rx         (1 x n) values for x-axis
%       ry         (1 x m) for y-axis
%       rz         (1 x v) values for z-axis 
%       S          (1 x 3) source point (x,y,z)
%       R          (1 x 3) receiver point (x,y,z)
%       L          (1 x 3) room dimension (Lx,Ly,Lz)
%       phase      signal phase
%       omega      2*pi*f | f : frequency
%       c          propagation speed
%       alpha      (1 x 6) Absorption coefficient for every wall
%       order      image order - defines the level of reflection
%       spacing    spacing between each grid point
%       visualize  (boolean) whether to visualize
%   Ausgabe 
%       wave      (m x n)  pressure deviation at receiver
% 
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