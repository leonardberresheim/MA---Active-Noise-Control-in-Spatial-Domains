%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 31-Oct-2021 09:55:18 $ 
% IMAGE_SOURCE_PRESSURE_WAVE computes the pressure deviation at a receiver
% produced by a pressure wave emitted at a source in a room using
% the image source method.
%   [in_p, out_p_abs] = IMAGE_SOURCE_PRESSURE_WAVE(S,R,L,t,spacing,c,f,Q,rho,order,alpha,shift,geogebra) 
%   Eingabe 
%       S          (1 x 3) source point (x,y,z)
%       R          (1 x 3) receiver point (x,y,z)
%       L          (1 x 3) room dimension (Lx,Ly,Lz)
%       t          (1 x n) time array
%       spacing    space between each point on the grid (m)
%       c          speed of sound
%       f          input frequency
%       Q          source strength
%       rho        density of the propagation medium
%       order      image order - defines the level of reflection
%       alpha      (1 x 6) Absorption coefficient for every wall
%       geogebtra  (0 || 1) geometric information output
%   Ausgabe 
%       tot_output_pressure      (1 x n)  pressure deviation at receiver
% 
function [in_p, out_p_abs] = image_source_pressure_wave(S,R,L,t,spacing,c,f,Q,rho,order,alpha,shift,geogebra)
    % Transform source and receiver point to place them relative to a
    % coordiante system originated in the center of the room
    S = S + [L(1)/2 L(2)/2 L(3)/2];
    R = R + [L(1)/2 L(2)/2 L(3)/2];
    % Deklaration of points forming the walls
    % The walls are given in the following order if considering that 
    % The x axis is pointing to the right, the y to the back
    % and the z to the back
    % left | front | right | back | bottom | top
    A = [0 0 0; 0 0 0; L(1) 0 0; 0 L(2) 0; 0 0 0; 0 0 L(3)];
    B = [0 1 0; 0 0 1; L(1) 1 0; 1 L(2) 0; 0 1 0; 1 0 L(3)];
    C = [0 0 1; 1 0 0; L(1) 0 1; 0 L(2) 1; 1 0 0; 0 1 L(3)];
    % Conversion of points into the plane quation coefficients of the walls
    n_walls = size(A,1);
    wall = zeros(n_walls,4);
    for i=1:n_walls
       wall(i,:) = plane_equation(A(i,:),B(i,:),C(i,:)); 
    end

    % Computation of the image points of S in relation to the walls/planes
    % and its absorption coefficient.
    M = S;
    beta = ones(1,size(S,1));
    for i=1:order
        [M, beta] = point_mirror(wall,M,alpha,beta);
    end
    % Display planes for geogebra---------------------
    if(geogebra == 1)
        disp('----------------------------------------');
        disp('Plane and point coordinates for GeoGebra');
        disp('----------------------------------------');
        for i=1:n_walls
           disp(['Plane((' num2str(A(i,1)) ',' num2str(A(i,2)) ',' num2str(A(i,3)) '),(' num2str(B(i,1)) ',' num2str(B(i,2)) ',' num2str(B(i,3)) '),(' num2str(C(i,1)) ',' num2str(C(i,2)) ',' num2str(C(i,3)) '))']);
        end
        for i=1:size(M,1)
           disp(['(' num2str(M(i,1)) ',' num2str(M(i,2)) ',' num2str(M(i,3)) ')']);
        end
        disp('----------------------------------------'); 
    end
    
    %-------------------------------------------------
    % Computation of the pressure wave at R for Source and all images
    [in_p, out_p, out_p_abs] = old_pressure_wave(M, R, f, t, c, Q, rho, beta, spacing,shift);
    
    % Sum all output pressures
    out_p_abs = sum(out_p_abs,1);
    
end 