function Y = harmonicMatrix(L,the,phi)
%% AUTHOR    : Leonard Berresheim 
% HARMONICMATRIX computes the spherical harmonics function in matrix form
%   Y = HARMONICMATRIX(L,the,phi)
%   Input 
%       L          order
%       the        elevation
%       phi        azimuth
%   Output 
%       Y        (L+1 x 2*L+1) spherical harmonic matrix
% 
    Y = zeros(L+1,2*L+1);
    for idl=1:L+1
        l = idl-1;
        Ym = zeros(1,2*L+1);
        for idm=1:(2*l+1)
            m = idm-idl;
            Ym(idm) = Ylm(l,m,the,phi);
        end
        Y(idl,:) = Ym;
    end
end