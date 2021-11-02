%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 27-Oct-2021 18:02:00 $ 
% PRESSURE_WAVE returns the pressure deviation between a point source and a
% receiver for a given frequency.
%   [in_p, out_p, out_p_abs] = PRESSURE_WAVE(x0,x1,fe,t,c,beta) 
%   Eingabe 
%       x0      (m x 3) source point  
%       x1      (1 x 3) receiver point  
%       fe      frequency  
%       t       (1 x n) time
%       c       speed of sound
%       beta    absorption coefficients for each source 
%   Ausgabe 
%       in_p       (1 x n) input pressure
%       out_p      (m x n) output pressure  
%       out_p_abs  (m x n) output pressure for non-rigid walls
%
function [in_p, out_p, out_p_abs] = pressure_wave(x0,x1,fe, t, c,beta) 
    out_p = zeros(size(x1,1),length(t));
    out_p_abs = zeros(size(x1,1),length(t));
    
    omega = 2*pi*fe;

    in_p = imag(exp(-1i*omega*t));
    for j=1:size(x0,1)
        r = norm(x0(j,:) - x1);
        for i=1:length(t)
            if(t(i) < r/c)
                out_p(j,i) = 0;
            else
                out_p(j,i) = imag(exp(1i*omega.*(r/c-t(i)))/(4*pi*r));
                out_p_abs(j,i) = beta(j)*out_p(j,i);
            end
        end

    end
    
end 
