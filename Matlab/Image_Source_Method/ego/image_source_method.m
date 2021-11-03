%% AUTHOR    : Leonard Berresheim 
%% $DATE     : 29-Oct-2021 08:38:39 $ 
% IMAGE_SOURCE_METHOD implements the image order
%   [P_M] = IMAGE_SOURCE_METHOD(P_S,WAL) 
%   Eingabe 
%       P_s      (1 x 3) Source Point  
%       wall      (n x 4) wall plane equation coordinates
%       order    image order
%   Ausgabe 
%       P_m      (n^order x 3) Image points
% 
function [P_m] = image_source_method(P_s,wall, order) 
    P_m = zeros(size(wall,1), 3);
    for i=0:size(wall,1)
       P_m(i) = point_mirror(wall(i), P_s); 
    end
end 
