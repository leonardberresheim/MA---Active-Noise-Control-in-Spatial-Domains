function P = legendreWave(r,k,plotting)
    % k - cartesian to spherical conversion
    [rho_k,the_k,phi_k] = my_cart2sph(k);
    % Summation limit
    L = ceil(exp(1)*rho_k*(2*max(max((r))))/2);
    % Unit Vector of k and r
    uk = unitvec(k);
    ur = unitvec(r);
    % Rho of r
    [rho_r,~,~] = my_cart2sph(r);
    % Product of uk and ur
    prod_uk_ur = uk(1).*ur(1,:) + uk(2).*ur(2,:) + uk(3).*ur(3,:);
    
    
    % Computation of wave
    P = zeros(1,length(r(1)));
    parfor l=0:L
        P = P + (2*l+1)*1i^l*sphbessel(l,rho_k.*rho_r).*legendreP(l,prod_uk_ur);
    end
    
    if(plotting == 1)
        plot(r(1,:),imag(P));
        xlabel("Distance in [m]");
        ylabel("Pressure in [PA]");
        title("Legendre wave in 1D");
    end
    
    
end