%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 28-Oct-2021 15:28:19 $ 
% PLANE_EQUATION returns the coefficients for the plane given by 3 points 
%   [A,B,C,D] = PLANE_EQUATION(A,B,C) 
%   Eingabe 
%       A,B,C   (1 x 3) Points forming plane    
%   Ausgabe 
%       plane   (1 x 4) Plane equation coefficients [a,b,c,d]
% 
function plane = plane_equation(A,B,C) 
    plane(1) = (B(2) - A(2))*(C(3)-A(3))-(C(2)-A(2))*(B(3)-A(3));
    plane(2) = (B(3)-A(3))*(C(1)-A(1))-(C(3)-A(3))*(B(1)-A(1));
    plane(3) = (B(1)-A(1))*(C(2)-A(2))-(C(1)-A(1))*(B(2)-A(2));
    plane(4) = -(plane(1)*A(1)+plane(2)*A(2)+plane(3)*A(3));
end 
