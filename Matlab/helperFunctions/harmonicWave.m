function P = harmonicWave(L,r,k,plotting)
%% AUTHOR    : Leonard Berresheim 
% HARMONICWAVE returns a 1-dimentional wave using the harmonic for a plane
% wave
%   P = harmonicWave(L,r,k,plotting)
%   Input 
%       L         degree
%       r         (1 x n) distance
%       k         wave number
%       plotting  (boolean) whether to plot resulting wave
%   Output 
%       P        (1 x n) wave


    % k - cartesian to spherical conversion
    [rho_k,the_k,phi_k] = my_cart2sph(k);
    
    % Rho of r
    [rho_r,the_r,phi_r] = my_cart2sph(r);
    % Summation limit
    %L = ceil(exp(1)*rho_k*(sqrt(2)*max(max((r))))/2);
    
    % Computation of wave
    P = zeros(1,length(r(1)));
    parfor l=0:L
        for m=-l:l
            P = P + 1i^l.*sphbessel(l,rho_k.*rho_r).*cYlm(l,m,the_k,phi_k).*Ylm(l,m,the_r,phi_r);
        end
    end
    
    P = 4.*pi.*P;
    
    if(plotting == 1)
        plot(r(1,:),imag(P));
        xlabel("Distance in [m]");
        ylabel("Pressure in [PA]");
        title("Harmonic wave in 1D");
    end
    
end