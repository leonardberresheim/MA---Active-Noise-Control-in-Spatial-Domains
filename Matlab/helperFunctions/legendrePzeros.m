function fz = legendrePzeros(N,visualize)
%% AUTHOR    : Leonard Berresheim 
% LEGENDREPZEROS returns roots for the legendre polynome
% wave
%   fz = legendrePzeros(N,visualize)
%   Input 
%       N           degree
%       visualize   (boolean) whetger to visualite results
%   Output 
%       fz          roots 

    x = linspace(0,pi,1000);
    y = @(x) legendreP(N+1,cos(x));
    zx = y(x).*circshift(y(x),[-1]) <= 0;  % Estimate zero crossings
    zx = zx(1:end-1);                      % Eliminate any due to ‘wrap-around’ effect
    zx = x(zx);
    fz = zeros(1,length(zx));
    for k1 = 1:length(zx)
        fz(k1) = fzero(y, zx(k1));
    end
    if(visualize == 1)
        
        plot(x,y(x),fz,zeros(1,length(fz)),'.');
        title(sprintf("Roots for legendre Polynome of degree %i of cos(theta)",N)); 

    end
end