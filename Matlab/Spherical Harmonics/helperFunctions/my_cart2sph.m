function [RHO,TH,PHI] = my_cart2sph(X)
    RHO = sqrt(X(1,:).^2+X(2,:).^2+X(3,:).^2);
    TH = atan(sqrt(X(1,:).^2+X(2,:).^2)./X(3,:));
    PHI = atan2(X(2,:),X(1,:));
end