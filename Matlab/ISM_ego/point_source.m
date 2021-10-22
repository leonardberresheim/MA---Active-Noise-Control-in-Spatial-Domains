function point_source(p_source, p_receiver, frequency, size_param, spacing)


    % =========================================================================
    % SIMULATION
    % =========================================================================
    
    
    % create the computational grid
    Nx = size_param;           % number of grid points in the x (row) direction
    Ny = size_param;           % number of grid points in the y (column) direction
    dx = spacing;    	% grid point spacing in the x direction [m]
    dy = dx;            % grid point spacing in the y direction [m]
    kgrid = kWaveGrid(Nx, dx, Ny, dy);

    % define the properties of the propagation medium
    medium.sound_speed = 343;  % [m/s]
    medium.alpha_coeff = 0.75;  % [dB/(MHz^y cm)]
    medium.alpha_power = 1.5;

    % create the time array
    kgrid.makeTime(medium.sound_speed);

    % define a multiple source point
    source.p_mask = zeros(Nx, Ny);
    for i = 1:size(p_source,1)
        source.p_mask(p_source(i,1) + (Nx/2), p_source(i,2) + (Ny/2)) = 1;
    end


    % define a time varying sinusoidal source
    source_freq = frequency;   % [Hz]
    source_mag = 2;         % [Pa]
    source.p = source_mag * sin(2 * pi * source_freq * kgrid.t_array);

    % filter the source to remove high frequencies not supported by the grid
    source.p = filterTimeSeries(kgrid, medium, source.p);

    % define a single sensor point
    sensor.mask = zeros(Nx, Ny);
    sensor.mask(p_receiver(1)+(Nx/2), p_receiver(2)+(Ny/2)) = 1;

    % define the acoustic parameters to record
    sensor.record = {'p', 'p_final'};

    % run the simulation
    sensor_data = kspaceFirstOrder2D(kgrid, medium, source, sensor);

    % =========================================================================
    % VISUALISATION
    % =========================================================================

    % plot the final wave-field
    figure;
    imagesc(kgrid.y_vec * 1e3, kgrid.x_vec * 1e3, ...
        sensor_data.p_final + source.p_mask + sensor.mask, [-1, 1]);
    colormap(getColorMap);
    ylabel('x-position [mm]');
    xlabel('y-position [mm]');
    axis image;

    % plot the simulated sensor data
    figure;
    [t_sc, scale, prefix] = scaleSI(max(kgrid.t_array(:)));

    subplot(2, 1, 1);
    plot(kgrid.t_array * scale, source.p, 'k-');
    xlabel(['Time [' prefix 's]']);
    ylabel('Signal Amplitude');
    axis tight;
    title('Input Pressure Signal');

    subplot(2, 1, 2);
    plot(kgrid.t_array * scale, sensor_data.p, 'r-');
    xlabel(['Time [' prefix 's]']);
    ylabel('Signal Amplitude');
    axis tight;
    title('Sensor Pressure Signal');
end