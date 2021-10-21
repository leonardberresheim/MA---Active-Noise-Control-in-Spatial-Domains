clearvars;

p_receiver = [-8,8];
frequency = 0.25e6; % Hz

p_source = [0,0;15,15];
p_wall = [-20 -20 -20 20; -15 -15 15 -15;] ;%[20 20 20 -20; -20 -20 -20 20; -15 -15 15 -15; -15 15 15 15];%;-20 0 0 -20; 20 0 0 -20; -20 0 0 20];

p_source_and_image = image_source(p_source, p_wall);

point_source(p_source_and_image, p_receiver, frequency);