function [x,y] = plotSamples(N,phi_l,theta_q)
    nl = length(phi_l);
    x = phi_l;
    y = ones(1,nl)*theta_q(1);
    for i=2:length(theta_q)
        x = [x phi_l];
        y = [y ones(1,nl)*theta_q(i)];
    end
    plot(rad2deg(x),rad2deg(y),'.');
    xlabel("\theta [degree]");
    ylabel("\phi [degree]");
    title(sprintf("Gaussian Sampling distribution for N = %i", N));
end