function wave = monopoleWave(s,r,mag,rho_k,visualize)
%% AUTHOR    : Leonard Berresheim 
% MONOPOLEWAVE computes a monopole wave using the Greens function
% wave
%   wave = monopoleWave(s,r,mag,rho_k,visualize)
%   Input 
%       s           source position
%       r           receiver positions
%       mag         magnitude
%       rho_k       wave number
%       visualize   (boolean) whether to plot resulting wave
%   Output 
%       wave        (1 x n) wave

    wave = zeros(size(r,2),size(r,2));
    rho = 1200; Q = 1; c = 343;
    for idy = 1:size(r,2)
        for idx = 1:size(r,2)
            SRnorm = norm(s-[r(1,idx);r(2,idy);r(3,1)]);
            wave(idy,idx) = mag*exp(1i*rho_k*SRnorm)/(4*pi*SRnorm); 
        end
    end
    if(visualize == 1)
        imagesc(r(2,:),r(1,:),imag(wave));
        xlabel("Distance in [m]");
        ylabel("Distance in [m]");
        title("Point Source wave");
        colorbar;
    end
    
end