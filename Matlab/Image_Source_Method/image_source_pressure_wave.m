%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 31-Oct-2021 09:55:18 $ 
% IMAGE_SOURCE_PRESSURE_WAVE.M 
%   [TOT_OUTPUT_PRESSURE] = IMAGE_SOURCE_PRESSURE_WAVE(S,R,Lx,Ly,Lz,T,C,F) 
%   Eingabe 
%       S      (? x ?)  
%       R      (? x ?)  
%       Lx     (? x ?)  
%       Ly     (? x ?)  
%       Lz     (? x ?)  
%       t      (? x ?)  
%       c      (? x ?)  
%       f      (? x ?)  
%   Ausgabe 
%       tot_output_pressure      (? x ?)  
% 
function [tot_output_pressure] = image_source_pressure_wave(S,R,Lx,Ly,Lz,t,c,f) 
    % Deklaration of points forming the walls
    A = [0 0 0; 0 0 0; Lx 0 0; 0 Ly 0;];%[0 0 0; 0 0 0; 0 0 0; Lx 0 0];%; 0 Ly 0; 0 0 Lz];
    B = [0 1 0; 0 0 1; Lx 1 0; 1 Ly 0;];%[0 1 0; 0 1 0; 0 0 1; Lx 1 0];%; 1 Ly 0; 1 0 Lz];
    C = [0 0 1; 1 0 0; Lx 0 1; 0 Ly 1];%[1 0 0; 0 0 1; 1 0 0; Lx 0 1];%; 0 Ly 1; 0 1 Lz];
    % Conversion of points into the plane quation coefficients of the walls
    n_walls = size(A,1);
    wall = zeros(n_walls,4);
    for i=1:n_walls
       wall(i,:) = plane_equation(A(i,:),B(i,:),C(i,:)); 
    end

    % Computation of the image points of P in relation to the walls/planes
    M = point_mirror(wall,S);
    
    % Display planes for geogebra---------------------
    for i=1:n_walls
       disp(['Plane((' num2str(A(i,1)) ',' num2str(A(i,2)) ',' num2str(A(i,3)) '),(' num2str(B(i,1)) ',' num2str(B(i,2)) ',' num2str(B(i,3)) '),(' num2str(C(i,1)) ',' num2str(C(i,2)) ',' num2str(C(i,3)) '))']);
    end
    disp(['(' num2str(S(1)) ',' num2str(S(2)) ',' num2str(S(3)) ')']);
    for i=1:n_walls
       disp(['(' num2str(M(i,1)) ',' num2str(M(i,2)) ',' num2str(M(i,3)) ')']);
    end
    %-------------------------------------------------
    % Computation of the pressure wave at R for Source and all images
    S_and_M = [S;M];
    [input_pressure, output_pressure] = pressure_wave(S_and_M, R, f, t, c);
    
    % Plot output pressures
    n_pressures = size(S_and_M,1);
    subplot(n_pressures+2,1,1);
    plot(t,input_pressure)
    title("Input pressure");
    for i=1:n_pressures
       subplot(n_pressures+2,1,i+1);
       plot(t, output_pressure(i,:));
       title(["Output pressure from image " i]);
    end

    tot_output_pressure = sum(output_pressure,1);
    subplot(n_pressures+2,1,n_pressures+2);
    plot(t, tot_output_pressure);
    title("Sum of output pressures");



    end 
