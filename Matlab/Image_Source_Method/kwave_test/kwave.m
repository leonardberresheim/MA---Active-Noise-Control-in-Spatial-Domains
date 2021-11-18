function [p,t,prefix,scale] = kwave(p_receiver,Pa,f,density,spacing,Nt,dt,doPlot)

    % create the computational grid
    Nx = 128;           % number of grid points in the x (row) direction
    Ny = 128;           % number of grid points in the y (column) direction
    dx = spacing;    	% grid point spacing in the x direction [m]
    dy = dx;            % grid point spacing in the y direction [m]
    kgrid = kWaveGrid(Nx, dx, Ny, dy);

    p_source = [0,0];

    % define the properties of the propagation medium
    medium.sound_speed = 343;  % [m/s]
    medium.density = density;
    %medium.alpha_coeff = 0.75;  % [dB/(MHz^y cm)]
    %medium.alpha_power = 1.5;

    % create the time array
    %kgrid.makeTime(medium.sound_speed);

    kgrid.Nt = Nt;
    kgrid.dt = dt;
    
    % define a single source point
    source.p_mask = zeros(Nx, Ny);
    source.p_mask(p_source(1) + Nx/2, p_source(2) + Ny/2) = 1;

    % define a time varying sinusoidal source
    source_freq = f;   % [Hz]
    source_mag = Pa;         % [Pa]
    source.p = source_mag * sin(2 * pi * source_freq * kgrid.t_array);

    % filter the source to remove high frequencies not supported by the grid
    %source.p = filterTimeSeries(kgrid, medium, source.p);

    % define a single sensor point
    sensor.mask = zeros(Nx, Ny);
    sensor.mask(p_receiver(1) + Nx/2, p_receiver(2) + Ny/2) = 1;

    % define the acoustic parameters to record
    sensor.record = {'p', 'p_final'};

    % run the simulation
    sensor_data = kspaceFirstOrder2D(kgrid, medium, source, sensor);

    % =========================================================================
    % VISUALISATION
    % =========================================================================

    [t_sc, scale, prefix] = scaleSI(max(kgrid.t_array(:)));

if(doPlot == 1)
   figure;
    imagesc(kgrid.y_vec * 1e3, kgrid.x_vec * 1e3, ...
        sensor_data.p_final + source.p_mask + sensor.mask, [-1, 1]);
    colormap(getColorMap);
    ylabel('x-position [mm]');
    xlabel('y-position [mm]');
    axis image; 
end

    
    p = sensor_data.p;
    t = kgrid.t_array;

end
