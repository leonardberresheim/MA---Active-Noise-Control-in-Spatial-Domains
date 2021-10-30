%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 27-Oct-2021 18:02:00 $ 
% PRESSURE_WAVE return the pressure deviation between a point source and a
% receiver for a given frequency.
%   [in_p, out_p] = PRESSURE_WAVE(x0,x1,fe,t,c) 
%   Eingabe 
%       x0      (1 x 2) source point  
%       x1      (m x 2) receiver point  
%       fe      frequency  
%       t       (1 x n) time
%       c       speed of sound
%   Ausgabe 
%       in_p    (1 x n) input pressure
%       out_p   (m x n) output pressure  
%
function [in_p, out_p] = pressure_wave(x0,x1,fe, t, c) 
    out_p = zeros(size(x1,1),length(t));
    
    omega = 2*pi*fe;

    in_p = imag(exp(-1i*omega*t));
    for j=1:size(x1,1)
        r = norm(x0 - x1(j,:));
        for i=1:length(t)
            if(t(i) < r/c)
                out_p(j,i) = 0;
            else
                out_p(j,i) = imag(exp(1i*omega.*(r/c-t(i)))/(4*pi*r));
            end
        end

    end
    
end 
