function y = myDot(rho_k,the_k,phi_k,rho_r,the_r,phi_r)
    y = rho_k.*rho_r.*(sin(the_k).*sin(the_r).*cos(phi_k-phi_r)+cos(the_k).*cos(the_r));
end