function fz = legendrePzeros(N)
    x = linspace(0,pi,1000);
    y = @(x) legendreP(N+1,cos(x));
    zx = y(x).*circshift(y(x),[-1]) <= 0;  % Estimate zero crossings
    zx = zx(1:end-1);                      % Eliminate any due to ‘wrap-around’ effect
    zx = x(zx);
    fz = zeros(1,length(zx));
    for k1 = 1:length(zx)
        fz(k1) = fzero(y, zx(k1));
    end
    plot(x,y(x),fz,zeros(1,length(fz)),'.');
    title(sprintf("Roots for legendre Polynome of degree %i of cos(theta)",N)); 
end