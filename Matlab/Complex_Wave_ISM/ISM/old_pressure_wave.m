%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 27-Oct-2021 18:02:00 $ 
% PRESSURE_WAVE returns the pressure deviation between a point source and a
% receiver for a given frequency.
%   [in_p, out_p, out_p_abs] = PRESSURE_WAVE(x0,x1,fe,t,c,Q,beta,spacing) 
%   Eingabe 
%       x0         (m x 3) source point  
%       x1         (1 x 3) receiver point  
%       fe         frequency  
%       t          (1 x n) time
%       c          speed of sound
%       Q          source strength
%       rho        density of the medium
%       beta       absorption coefficients for each source 
%       spacing    spacing between each grid point (meters)
%   Ausgabe 
%       in_p       (1 x n) input pressure
%       out_p      (m x n) output pressure  
%       out_p_abs  (m x n) output pressure for non-rigid walls
%
function [in_p, out_p, out_p_abs] = pressure_wave(x0,x1,fe, t, c, Q, rho, beta, spacing,shift) 
    out_p = zeros(size(x0,1),length(t));
    out_p_abs = zeros(size(x0,1),length(t));
    
    omega = 2*pi*fe;
    rho = 1.125;
    k = omega/c;
    in_p = zeros(size(x0,1),length(t));
    
    for j=1:size(x0,1)
        in_p(j,:) = imag(exp(-1i*(omega*t+shift(j))));
        r = spacing*norm(x0(j,:) - x1);
        for i=1:length(t)
            % The Pressure deviation is set to 0 while the pressure wave
            % emited by source has not yet reached the receiver
            if(t(i) < r/c)
                out_p(j,i) = 0;
            else
                out_p(j,i) = imag(1i*((Q*rho*c*k)/(4*pi*r))*exp(1i*(omega*t(i)-k*r+shift(j))));
                %out_p(j,i) = real(exp(1i*omega*(r/c-t(i)))/(4*pi*r));
            end
            
            out_p_abs(j,i) = beta(j)*out_p(j,i);
        end

    end
    
end 
