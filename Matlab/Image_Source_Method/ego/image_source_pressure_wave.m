%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 31-Oct-2021 09:55:18 $ 
% IMAGE_SOURCE_PRESSURE_WAVE computes the pressure deviation at a receiver
% produced by a pressure wave emitted at a source in a room using
% the image source method.
%   [TOT_OUTPUT_PRESSURE] = IMAGE_SOURCE_PRESSURE_WAVE(S,R,Lx,Ly,Lz,T,SCALE,C,F,order,alpha) 
%   Eingabe 
%       S      (1 x 3) source point
%       R      (1 x 3) receiver point
%       Lx     length of room
%       Ly     depth of room
%       Lz     height of room
%       t      (1 x n)
%       scale  scale for plotting - returned by th ekwave model
%       spacing  space between each point on the grid
%       c      speed of sound
%       f      input frequency
%       alpha  (1 x 6) Absorption coefficient for every wall
%       order  image order - defines the level of reflection
%   Ausgabe 
%       tot_output_pressure      (1 x n)  pressure deviation at receiver
% 
function [tot_output_pressure_abs] = image_source_pressure_wave(S,R,Lx,Ly,Lz,t,scale,spacing,c,f,order,alpha) 
    % Transform source and receiver point to place them relative to a
    % coordiante system originated in the center of the room
    S = S + [Lx/2 Ly/2 0];
    R = R + [Lx/2 Ly/2 0];
    % Deklaration of points forming the walls
    A = [0 0 0; 0 0 0; Lx 0 0; 0 Ly 0];%; 0 0 0; 0 0 Lz];
    B = [0 1 0; 0 0 1; Lx 1 0; 1 Ly 0];%; 0 1 0; 1 0 Lz];
    C = [0 0 1; 1 0 0; Lx 0 1; 0 Ly 1];%; 1 0 0; 0 1 Lz];
    % Conversion of points into the plane quation coefficients of the walls
    n_walls = size(A,1);
    wall = zeros(n_walls,4);
    for i=1:n_walls
       wall(i,:) = plane_equation(A(i,:),B(i,:),C(i,:)); 
    end

    % Computation of the image points of S in relation to the walls/planes
    % and its absorption coefficient.
    M = S;
    beta = 1;
    for i=1:order
        [M, beta] = point_mirror(wall,M,alpha,beta);
    end
    % Display planes for geogebra---------------------
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
    %-------------------------------------------------
    % Computation of the pressure wave at R for Source and all images
    [input_pressure, output_pressure, output_pressure_abs] = pressure_wave(M, R, f, t, c,beta,spacing);
    % Plot output pressures
    n_pressures = size(M,1);
    subplot(2,1,1);
    plot(t*scale,input_pressure,'k-');
    axis tight;
    title("Input pressure");


    tot_output_pressure_abs = sum(output_pressure_abs,1);
    subplot(2,1,2);
    plot(t*scale, tot_output_pressure_abs/100, 'r-');
    axis tight;
    title("Sum of output pressures at receiver concidering absorption coefficients");
    end 