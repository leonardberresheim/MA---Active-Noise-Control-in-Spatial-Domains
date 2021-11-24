%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 19-Nov-2021 $ 
function [out_p] = complex_wave_ism(wave,S,R,L,t,Fs,Ts,thresh,spacing,c,Q,rho,order,alpha,geogebra)
% COMPLEX_WAVE_ISM computes the pressure deviation at a receiver
% produced by a complex pressure wave emitted at a source in a room using
% the image source method.
%   [out_p] = COMPLEX_WAVE_ISM(wave,S,R,L,t,spacing,c,Q,rho,order,alpha,geogebra) 
%   Eingabe 
%       wave       (1 x n) Complex wave
%       S          (1 x 3) source point (x,y,z)
%       R          (1 x 3) receiver point (x,y,z)
%       L          (1 x 3) room dimension (Lx,Ly,Lz)
%       t          (1 x n) time array
%       Fs         sampling frequency
%       Ts         sampling period
%       thresh     threshold for wave decomposition
%       spacing    space between each point on the grid (m)
%       c          speed of sound
%       f          input frequency
%       Q          source strength
%       rho        density of the propagation medium
%       order      image order - defines the level of reflection
%       alpha      (1 x 6) Absorption coefficient for every wall
%       geogebtra  (0 || 1) geometric information output
%   Ausgabe      
%       out_p      (1 x n)  pressure deviation at receiver
% 
    [wave_freq,mag,sine_waves] = decompose_wave(wave,t,Fs,Ts,thresh);
    out_p = zeros(size(wave_freq,2),size(sine_waves,2));
    for i=1:size(wave_freq,2)
       out_p(i,:) = image_source_pressure_wave(S,R,L,t,spacing,c,wave_freq(i),mag(i),Q,rho,order,alpha,geogebra);
    end
    
    out_p = sum(out_p,1);
    %out_p = arrayfun(@(x) image_source_pressure_wave(S,R,L,t,spacing,c,x,Q,rho,order,alpha,geogebra),wave_freq);

end