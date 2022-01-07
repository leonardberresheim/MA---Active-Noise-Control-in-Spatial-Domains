function cmpWaves(w1,w2,visualize)
    sz = size(w1);
    if(sz(1) <= 1)
        reError = max(abs(real(w1-w2)));
        imError = max(abs(imag(w1-w2)));
        meanError = mean([abs(real(w1-w2)) abs(imag(w1-w2))]);
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
    else
        reError = max(max(abs(real(w1-w2))));
        imError = max(max(abs(imag(w1-w2))));
        meanError = mean(mean([abs(real(w1-w2)) abs(imag(w1-w2))]));
        if(visualize == 1)
           figure;
           subplot(221);
           imagesc(abs(imag(w1-w2))); colorbar;
           title("Error for real part");
           subplot(222);
           imagesc(abs(real(w1-w2))); colorbar;
           title("Error for imag part");
        end
    end
    
    sprintf("Max real error:  %0.2e",reError)
    sprintf("Max imag error:  %0.2e", imError)
    sprintf("Mean error: %0.2e",meanError)
    
end