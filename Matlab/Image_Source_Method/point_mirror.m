%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 28-Oct-2021 15:47:13 $ 
% POINT_MIRROR 
%   [M] = POINT_MIRROR(A,B,C,D,P) 
%   Eingabe 
%       plane  (n x 4) Plane equation coefficient [a,b,c,d]
%       P      (1 x 3) Source point
%   Ausgabe 
%       M      (n x 3) Mirror point  
% 
function [M] = point_mirror(plane, P) 
    M_tmp = zeros(size(plane,1)*size(P,1),3);
    x = 1;
    for j=1:size(P,1)
        for i=1:size(plane,1)
            k = (-plane(i,1)*P(j,1)-plane(i,2)*P(j,2)-plane(i,3)*P(j,3)-plane(i,4)) / (plane(i,1)^2+plane(i,2)^2+plane(i,3)^2);
            M_tmp(x,1) = 2 * (plane(i,1)*k+P(j,1)) - P(j,1);
            M_tmp(x,2) = 2 * (plane(i,2)*k+P(j,2)) - P(j,2);
            M_tmp(x,3) = 2 * (plane(i,3)*k+P(j,3)) - P(j,3);
            x = x+1;
        end
    end
    M = M_tmp;
end 
