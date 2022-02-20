function P = monopoleWaveSpherical(mag,rho_s,the_s,phi_s,rho_r,the_r,phi_r,rho_k)
%% AUTHOR    : Leonard Berresheim 
% MONOPOLEWAVESPHERICAL implement monopoleWave for spherical coordinates 
% wave
%   wave = monopoleWave(s,r,mag,rho_k,visualize)
%   Input 
%       mag                   magnitude
%       rho_s,the_s,phi_s     source position in spherical coordinates
%       rho_r,the_r,phi_r     receiver positions spherical coordinates
%       rho_k                 wave number
%   Output 
%       P        (1 x n) wave

    SRnorm = sqrt(rho_s.^2 + rho_r.^2 -2.*rho_s.*rho_r.*cos(the_s-the_r)-2.*rho_s.*rho_r.*sin(the_s).*sin(the_r).*(cos(phi_s-phi_r)-1));
    P = mag.*exp(1i.*rho_k.*SRnorm)./(4.*pi.*SRnorm); 
end