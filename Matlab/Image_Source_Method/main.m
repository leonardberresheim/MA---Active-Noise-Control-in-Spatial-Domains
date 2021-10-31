clearvars;


Lx = 5;
Ly = 5;
Lz = 5;
t = 0:0.00001:0.1;
c = 343;
f = 2000;
order = 1;

R = [4,4,1];
S = [1,1,1];

tot_output_pressure = image_source_pressure_wave(S,R,Lx,Ly,Lz,t,c,f,order);