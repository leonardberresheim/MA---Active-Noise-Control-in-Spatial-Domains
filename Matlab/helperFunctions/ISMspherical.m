function P = ISMspherical(rho_s,the_s,phi_s,rho_r,the_r,phi_r,L,mag,phase,omega,c,alpha,order)
%% AUTHOR    : Leonard Berresheim 
% ISMSPHERICAL implements the ISM function for spherical coordinates
%   P = ISMspherical(rho_s,the_s,phi_s,rho_r,the_r,phi_r,L,mag,phase,omega,c,alpha,order)
%   Eingabe 
%       rho_s, the_s, phi_s     spherical coordinates of source
%       rho_r, the_r, phi_r     spherical coordinates of receiver
%       mag                     magnitude
%       phase                   phase
%       omega                   2*pi*f
%       c                       speed of sound propagation
%       alpha                   absorption coefficients
%       oder                    image source order
%   Ausgabe 
%       P                       resulting pressure deviation at receiver
% 
    S = my_sph2cart(the_s,phi_s,rho_s);
    R = my_sph2cart(the_r,phi_r,rho_r);
    P = ISM(S,R,L,mag,phase,omega,c,alpha,order);
end