function meanError = cmpWaves(w1,w2,r,visualize)
%% AUTHOR    : Leonard Berresheim 
% CMPWAVES is used to calculate the error between 2 wave and visualize the
% error for the real and the imaginary part
%   meanError = cmpWaves(w1,w2,r,visualize)
%   Input 
%       w1          (n x m) first wave
%       w2          (n x m) second wave
%       r           (1 x 3) axis values vector
%       visualize   (boolean) set to 1 to visualize error
%   Output 
%       meanError   mean error
% 

    sz = size(w1);
    % If the wave are 1-dimensional
    if(sz(1) <= 1)

        reError = max(abs(real(w1-w2)));
        imError = max(abs(imag(w1-w2)));
        meanErrorInter = [abs(real(w1-w2)) abs(imag(w1-w2))];
        meanError = mean(meanErrorInter(~isnan(meanErrorInter)));
        if(visualize == 1)
            figure;
            subplot(211);
            plot(abs(real(w1-w2)));
            ylabel("Error");
            title("Error for real part");
            subplot(212);
            plot(abs(imag(w1-w2)));
            ylabel("Error");
            title("Error for imag part");
        end
    % If 2-dimensional
    else
        reError = max(max(abs(real(w1-w2))));
        imError = max(max(abs(imag(w1-w2))));
        meanErrorInter = [abs(real(w1-w2)) abs(imag(w1-w2))];
        meanError = mean(mean(meanErrorInter(~isnan(meanErrorInter))));
        if(visualize == 1)
           figure;
           subplot(221);
           imagesc(r(1,:),r(2,:),abs(imag(w1-w2))); colorbar;
           xlabel("Distance in [m]"); ylabel("Distance in [m]");
           title("Error for real part");
           subplot(222);
           imagesc(r(1,:),r(2,:),abs(real(w1-w2))); colorbar;
           xlabel("Distance in [m]"); ylabel("Distance in [m]");
           title("Error for imag part");
        end
    end
    if(visualize == 1)
        sprintf("Max real error:  %0.2e",reError)
        sprintf("Max imag error:  %0.2e", imError)
        sprintf("Mean error: %0.2e",meanError)
    end
    
end