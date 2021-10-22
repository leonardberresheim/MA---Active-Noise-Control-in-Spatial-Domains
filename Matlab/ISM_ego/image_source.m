%------------------------------------------------------------------------
% image_source calculates the images of the source point according to the walls
%------------------------------------------------------------------------
%
% walls
% Input:
% p_source = (1 x 2) the source point 
% p_wall = (n x 4) the walls points [x0, y0, x1, y1] 
%
% Output:
% p_source_n_image = (n+1 x 2) the source point + image points.


function p_source_and_image = image_source(p_source, p_wall)
    % Prealocate space
    %p_source_and_image = zeros(size(p_source,1)*(size(p_wall,1)+1),2);
    idx = 1;
    for j=1:size(p_source,1)     
        P = p_source(j,:);
        p_source_and_image(idx,:) = P;
        idx = idx +1;
        for i=1:size(p_wall,1)
            R = [p_wall(i,1),p_wall(i,2)];
            Q = [p_wall(i,3),p_wall(i,4)];

            A = R(2) - Q(2);
            B = -(R(1) - Q(1));
            C = -A * Q(1) - B * Q(2);

            M = sqrt(A * A + B * B);

            A_1 = A / M;
            B_1 = B / M;
            C_1 = C / M;

            D = A_1 * P(1) + B_1 * P(2) + C_1;

            px_1 = P(1) - 2 * A_1 * D;
            py_1 = P(2) - 2 * B_1 * D;

            p_source_and_image(idx,:) = [px_1 py_1];
            idx = idx +1;
        end
    end
    % Some refelction produce an already existing image or even the source.
    % These can be removed.
    p_source_and_image = unique(p_source_and_image,'rows');
end