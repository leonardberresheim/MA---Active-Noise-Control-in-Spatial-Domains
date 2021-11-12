%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 28-Oct-2021 15:47:13 $ 
% POINT_MIRROR computes all images for the input sources in relation to the
% provided planes
%   [M, post_beta] = POINT_MIRROR(plane, P, alpha, pre_beta) 
%   Eingabe 
%       plane      (n x 6) Plane equation coefficient [a,b,c,d]
%       P          (m x 3) Source point
%       alpha      (1 x 6) Absorption coefficient for every wall/plane
%       pre_beta   (n x 1) Absorption of every source point
%   Ausgabe 
%       M          (n*m x 3) Mirror point + Source points
%       post_beta  (n*m x 1) absorption coefficient for every Mirror pont
function [M, post_beta] = point_mirror(plane, P, alpha, pre_beta) 
    % Saves the new mirror points
    M_tmp = zeros(size(plane,1)*size(P,1),3);
    % Saves the new absorption coefficients.
    post_beta_tmp = zeros(size(plane,1)*size(P,1),1);
    %post_beta_tmp(1:size(pre_beta)) = pre_beta;
    x = 1;
    for j=1:size(P,1)
        for i=1:size(plane,1)
            k = (-plane(i,1)*P(j,1)-plane(i,2)*P(j,2)-plane(i,3)*P(j,3)-plane(i,4)) / (plane(i,1)^2+plane(i,2)^2+plane(i,3)^2);
            M_tmp(x,1) = 2 * (plane(i,1)*k+P(j,1)) - P(j,1);
            M_tmp(x,2) = 2 * (plane(i,2)*k+P(j,2)) - P(j,2);
            M_tmp(x,3) = 2 * (plane(i,3)*k+P(j,3)) - P(j,3);
            post_beta_tmp(x) = pre_beta(j) * sqrt(1-alpha(i));
            
            %if (x > size(pre_beta) && size(pre_beta) ~= 0)
            %    post_beta_tmp(x) = pre_beta(j) * sqrt(1-alpha(i));
            %end
            
            x = x+1;
        end
    end
    % Remove duplicate rows in M
    %M = unique(M_tmp, 'rows', 'stable');
    M = P;
    post_beta = pre_beta;
    for i=1:size(M_tmp,1)
        isPresent = false;
        for j=1:size(M,1)
           if(M(j,:) == M_tmp(i,:))
              isPresent = true;
              break;
           end
        end
        if(isPresent == false)
           M = [M; M_tmp(i,:)];
           post_beta = [post_beta; post_beta_tmp(i)];
        end
    end
    
end 

