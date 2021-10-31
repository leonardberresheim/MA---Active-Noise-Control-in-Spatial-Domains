%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 31-Oct-2021 09:55:18 $ 
% IMAGE_SOURCE_PRESSURE_WAVE computes the pressure deviation at a source
% produced by a pressure wave emitted at a source in a room implementing
% the image source method.
%   [TOT_OUTPUT_PRESSURE] = IMAGE_SOURCE_PRESSURE_WAVE(S,R,Lx,Ly,Lz,T,C,F,order) 
%   Eingabe 
%       S      (1 x 3) source point
%       R      (1 x 3) receiver point
%       Lx     length of room
%       Ly     depth of room
%       Lz     height of room
%       t      (1 x n)
%       c      speed of sound
%       f      input frequency
%       order  image order - defines the level of reflection
%   Ausgabe 
%       tot_output_pressure      (1 x n)  pressure deviation at receiver
% 
function [tot_output_pressure] = image_source_pressure_wave(S,R,Lx,Ly,Lz,t,c,f,order) 
    % Deklaration of points forming the walls
    A = [0 0 0; 0 0 0; Lx 0 0; 0 Ly 0; 0 0 0; 0 0 Lz];
    B = [0 1 0; 0 0 1; Lx 1 0; 1 Ly 0; 0 1 0; 1 0 Lz];
    C = [0 0 1; 1 0 0; Lx 0 1; 0 Ly 1; 1 0 0; 0 1 Lz];
    % Conversion of points into the plane quation coefficients of the walls
    n_walls = size(A,1);
    wall = zeros(n_walls,4);
    for i=1:n_walls
       wall(i,:) = plane_equation(A(i,:),B(i,:),C(i,:)); 
    end

    % Computation of the image points of S in relation to the walls/planes
    M = S;
    for i=0:order
        M = [M; point_mirror(wall,M)];
    end
    % Remove duplicate rows in M
    uM = unique(M, 'rows', 'stable');
    % Display planes for geogebra---------------------
    for i=1:n_walls
       disp(['Plane((' num2str(A(i,1)) ',' num2str(A(i,2)) ',' num2str(A(i,3)) '),(' num2str(B(i,1)) ',' num2str(B(i,2)) ',' num2str(B(i,3)) '),(' num2str(C(i,1)) ',' num2str(C(i,2)) ',' num2str(C(i,3)) '))']);
    end
    for i=1:size(uM,1)
       disp(['(' num2str(uM(i,1)) ',' num2str(uM(i,2)) ',' num2str(uM(i,3)) ')']);
    end
    %-------------------------------------------------
    % Computation of the pressure wave at R for Source and all images
    [input_pressure, output_pressure] = pressure_wave(uM, R, f, t, c);
    
    % Plot output pressures
    n_pressures = size(uM,1);
    %subplot(n_pressures+2,1,1);
    subplot(2,1,1);
    plot(t,input_pressure)
    title("Input pressure");
%     for i=1:n_pressures
%        subplot(n_pressures+2,1,i+1);
%        plot(t, output_pressure(i,:));
%        title(["Output pressure from image " i]);
%     end

    tot_output_pressure = sum(output_pressure,1);
    subplot(2,1,2);
    %subplot(n_pressures+2,1,n_pressures+2);
    plot(t, tot_output_pressure);
    title("Sum of output pressures at receiver");
    end 