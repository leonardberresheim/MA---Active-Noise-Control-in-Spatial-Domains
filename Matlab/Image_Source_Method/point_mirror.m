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
    M = zeros(size(plane,1),3);
    for i=1:size(M,1)
        k = (-plane(i,1)*P(1)-plane(i,2)*P(2)-plane(i,3)*P(3)-plane(i,4)) / (plane(i,1)^2+plane(i,2)^2+plane(i,3)^2);
        M(i,1) = 2 * (plane(i,1)*k+P(1)) - P(1);
        M(i,2) = 2 * (plane(i,2)*k+P(2)) - P(2);
        M(i,3) = 2 * (plane(i,3)*k+P(3)) - P(3);
    end
end 

