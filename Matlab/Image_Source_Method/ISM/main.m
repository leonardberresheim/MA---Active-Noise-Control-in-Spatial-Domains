clearvars;


Lx = 5;
Ly = 5;
Lz = 5;
t = 0:0.00001:16;
c = 343;
f = 2000;
order = 2;
alpha = [0.5 0.5 0.5 0.5 0.5 0.5];%[0.6  0.9  0.5  0.6  1.0  0.8]; % Room absorbtion coefficient

R = [4,4,1];
S = [1,1,1];

tot_output_pressure = image_source_pressure_wave(S,R,Lx,Ly,Lz,t,c,f,order,alpha);