function P = monopoleWaveSpherical(rho_s,the_s,phi_s,rho_r,the_r,phi_r,rho_k)
    SRnorm = sqrt(rho_s.^2 + rho_r.^2 -2.*rho_s.*rho_r.*cos(the_s-the_r)-2.*rho_s.*rho_r.*sin(the_s).*sin(the_r).*(cos(phi_s-phi_r)-1));
    P = exp(1i.*rho_k.*SRnorm)./(4.*pi.*SRnorm); 
end