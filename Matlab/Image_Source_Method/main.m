clearvars;


Lx = 5;
Ly = 5;
Lz = 5;
A = [0 0 0; 0 0 0; Lx 0 0; 0 Ly 0;];%[0 0 0; 0 0 0; 0 0 0; Lx 0 0];%; 0 Ly 0; 0 0 Lz];
B = [0 1 0; 0 0 1; Lx 1 0; 1 Ly 0;];%[0 1 0; 0 1 0; 0 0 1; Lx 1 0];%; 1 Ly 0; 1 0 Lz];
C = [0 0 1; 1 0 0; Lx 0 1; 0 Ly 1];%[1 0 0; 0 0 1; 1 0 0; Lx 0 1];%; 0 Ly 1; 0 1 Lz];
wall = zeros(size(A,1),4);
for i=1:size(A,1);
   wall(i,:) = plane_equation(A(i,:),B(i,:),C(i,:)); 
end

P = [1,1,1];
M = point_mirror(wall,P);

for i=1:size(A,1)
   disp(['Plane((' num2str(A(i,1)) ',' num2str(A(i,2)) ',' num2str(A(i,3)) '),(' num2str(B(i,1)) ',' num2str(B(i,2)) ',' num2str(B(i,3)) '),(' num2str(C(i,1)) ',' num2str(C(i,2)) ',' num2str(C(i,3)) '))']);
end
disp(['(' num2str(P(1)) ',' num2str(P(2)) ',' num2str(P(3)) ')']);
for i=1:size(A,1)
   disp(['(' num2str(M(i,1)) ',' num2str(M(i,2)) ',' num2str(M(i,3)) ')']);
end

t = 0:0.00001:0.1;
c = 343;
f = 2000;
[input_pressure, output_pressure] = pressure_wave(P, M, f, t, c);

subplot(size(A,1)+2,1,1);
plot(t,input_pressure)
title("Input pressure");
for i=1:size(A,1)
   subplot(size(A,1)+2,1,i+1);
   plot(t, output_pressure(i,:));
   title(["Output pressure from image " i]);
end

pressure_sum = sum(output_pressure,1);
subplot(size(A,1)+2,1,size(A,1)+2);
plot(t, pressure_sum);
title("Sum of output pressures");

% t = 0:0.001:1;
% c = 343;
% f = 20;
% X_source = [0,0]; % Source coordinates
% X_receiver = [0,50]; % Receiver coordinates
% 
% [input_pressure, p] = pressure_wave(X_source, X_receiver, f, t, c);
% 
% subplot(2,1,1)
% plot(t,input_pressure)
% 
% subplot(2,1,2)
% plot(t,p)
