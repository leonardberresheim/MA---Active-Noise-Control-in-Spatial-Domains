function cY = cYlm(l,m,the,phi)
%% AUTHOR    : Leonard Berresheim 
% CYLM computes the complex conjugate of the spherical harmonics function
%   cY = cYlm(l,m,the,phi)
%   Input 
%       l           order
%       m           degree
%       the         elevation
%       phi         azimuth
%   Output 
%       p           conjugate harmonics function result for given
%                   parameters
% 

    cY = (-1)^m*Ylm(l,-m,the,phi);
end