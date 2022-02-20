function [len,pos] = loudspeaker_positions(N,sym)
%% AUTHOR    : Leonard Berresheim 
% LOUDSPEAKER_POSITIONS returns loudspeaker position for setup
% wave
%   [len,pos] = loudspeaker_positions(N,sym)
%   Input 
%       N         room dimension by which the positions have to be shifted
%       sym       whether to use symetric arrangement or not
%   Output 
%       len       number of loudspeakers
%       pos       position of loudspeakers

    if(sym == 1)
        pos = [4,3,2.5; 
               1.8,3,2.5;
               3,2,2.5;
               3,4.2,2.5;
               4.3,3.2,2.5;
               1.7,2.8,2.5;
               3.2,1.7,2.5; 
               2.8,4.2,2.5];
    elseif(sym == 0)
        pos = [4.5,3,2.5;
               1.5,3,2.5;
               3,1.5,2.5;
               3,4.5,2.5;
               4.2,1.8,2.5;
               1.8,1.8,2.5;
               4.2,4.2,2.5;
               1.8,4.2,2.5];
    end

                
    pos = [pos;
           0.5,0.5,4.5;
           5.5,5.5,4.5;
           5.5,0.5,4.5;
           0.5,5.5,4.5];
       
    pos = pos' - [N(1)/2;N(2)/2;N(3)/2];
    len = size(pos,2);
end