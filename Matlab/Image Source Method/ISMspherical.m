function P = ISMspherical(rho_s,the_s,phi_s,rho_r,the_r,phi_r,L,mag,phase,omega,c,alpha,order)
    S = my_sph2cart(the_s,phi_s,rho_s);
    R = my_sph2cart(the_r,phi_r,rho_r);
    P = ISM(S,R,L,mag,phase,omega,c,alpha,order);
end