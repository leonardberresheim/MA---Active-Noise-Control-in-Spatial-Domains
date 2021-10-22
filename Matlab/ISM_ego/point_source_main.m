clearvars;

p_receiver = [-8,8];
frequency = 0.25e6; % Hz
dimention = 256;
spacing = 100e-3/dimention;
image_order = 3;

p_source = [0,0];
p_wall = [15 15 15 -15];

for i=1:image_order
    p_source = image_source(p_source, p_wall);
end



point_source(p_source, p_receiver, frequency, dimention, spacing);