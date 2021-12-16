%% AUTHOR        : Bradley Treeby
%% $DATE         : 2nd December 2009$
%% $LAST UPDATE  : 4th May 2017$
% This function is part of the k-Wave Toolbox (http://www.k-wave.org)
% Copyright (C) 2009-2017 Bradley Treeby

% This file is part of k-Wave. k-Wave is free software: you can
% redistribute it and/or modify it under the terms of the GNU Lesser
% General Public License as published by the Free Software Foundation,
% either version 3 of the License, or (at your option) any later version.
% 
% k-Wave is distributed in the hope that it will be useful, but WITHOUT ANY
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
% FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
% more details. 
% 
% You should have received a copy of the GNU Lesser General Public License
% along with k-Wave. If not, see <http://www.gnu.org/licenses/>.
%
% monopole_point_source implements a time varying pressure source within a
% three-dimensional homogenous propagation medium.
%   [t,scale,prefix,in_p,out_p] = MONOPOLE_SOUND_SOURCE(p_source, p_receiver, frequency, size_param, spacing,Nt,dt,alpha)
%   Eingabe 
%       p_source      (m x 3) source point  
%       p_source      (m x 3) source point   
%       frequency     frequency  
%       size_param    (1 x 3) room dimension (Lx,Ly,Lz)
%       spacing       space between each grid point
%       Nt            (n) number of time steps
%       dt            size of time steps (in s)
%       alpha         wall absorption coefficient
%   Ausgabe 
%       t             (1 x n) time array  
%       out_p         (m x n) output pressure  
%       scale         time axis scale for plotting
%       prefix        time prefix for plotting




function [t,scale,prefix,in_p,out_p] = monopole_sound_source(p_source, p_receiver, frequency, size_param, spacing,Nt,dt)

    % =========================================================================
    % SIMULATION
    % =========================================================================
    
    
    % create the computational grid
    Nx = size_param(1);           % number of grid points in the x (row) direction
    Ny = size_param(2);           % number of grid points in the y (column) direction
    Nz = size_param(3);
    dx = spacing;    	% grid point spacing in the x direction [m]
    dy = spacing;            % grid point spacing in the y direction [m]
    dz = spacing;

    
    kgrid = kWaveGrid(Nx, dx, Nx, dx, Nx, dx);

    % define the properties of the propagation medium
    medium.sound_speed = 343;  % [m/s]

    % return time intervals from kgrid
    kgrid.Nt = Nt;
    kgrid.dt = dt;
    t = kgrid.t_array;
    
    % define a multiple source point
    source.p_mask = zeros(Nx,Ny,Nz);
    for i = 1:size(p_source,1)
        source.p_mask(p_source(i,1) + (Nx/2), p_source(i,2) + (Ny/2), p_source(i,3) + (Nz/2)) = 1;
    end


    % define a time varying sinusoidal source
    source_freq = frequency;   % [Hz]
    source_mag = 2;         % [Pa]
    source.p = source_mag * sin(2 * pi * source_freq * kgrid.t_array);
    

    % filter the source to remove high frequencies not supported by the grid
    % source.p = filterTimeSeries(kgrid, medium, source.p);

    % define a single sensor point
    sensor.mask = zeros(Nx, Ny, Nz);
    sensor.mask(p_receiver(1)+(Nx/2), p_receiver(2)+(Ny/2), p_receiver(3)+(Nz/2)) = 1;

    % define the acoustic parameters to record
    sensor.record = {'p', 'p_final'};

    % run the simulation
    % Set PMLAlpha to 0 to simulate reflecting walls
    sensor_data = kspaceFirstOrder3D(kgrid, medium, source, sensor, 'PMLAlpha', 0);

    
    % Return input pressure and output pressure
    in_p = source.p;
    out_p = sensor_data.p;
    % =========================================================================
    % VISUALISATION
    % =========================================================================

    % Scalling for plotting

    [t_sc, scale, prefix] = scaleSI(max(kgrid.t_array(:)));

end