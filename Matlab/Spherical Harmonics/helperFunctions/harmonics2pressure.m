function P = harmonics2pressure(Clm,k,r,sz)
    phi_r = zeros(sz); the_r = phi_r; rho_r = phi_r;
    P = phi_r;
    L = size(Clm,1)-1;
    
    for idy=1:sz(1)
        for idx=1:sz(2)
            [rho_r(idy,idx),the_r(idy,idx),phi_r(idy,idx)] = my_cart2sph([r(1,idx);r(2,idy);r(3,1)]);
        end
    end
    
    h = waitbar(0,"Initialising");
    for l=0:L
        waitbar(l/L,h,"Loading...");
        idl=l+1;
        for m=-l:l
            idm=m+idl;
            P = P + Clm(idl,idm).*sphbessel(l,k.*rho_r).*Ylm(l,m,the_r,phi_r);
        end
    end
    close(h);
    
    
end