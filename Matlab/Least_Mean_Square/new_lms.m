%% AUTHOR    : Leonard Berresheim
function [e,y_ism]=new_lms(mu,M,x,d,S1,S2,R,L,t,Fs,Ts,thresh,spacing,c,Q,rho,order,alpha,geogebra)
% LMS returns the filter coefficients from the least-mean-square algorithm
%   [e,y]=LMS(mu,M,x,d,S1,S2,R,L,t,Fs,Ts,thresh,spacing,c,Q,rho,order,alpha,geogebra);
%   Eingabe 
%       mu      (1 x 1) step size
%       M       (1 x 1) filter length
%       d       (n x 1) reference signal
%       x       (n x 1) input signal
%       
%   Ausgabe 
%       e       (n x 1) estimation error
%       y       (n x 1) final filter coefficients
% 
    %number of samples of the input signal
    N=length(x);
    %inital values: 0
    w=zeros(1,M);
    y = zeros(1,N);
    % The pressure deviation caused by the signal emited by the primary source S1 at the error
    % microphone is computed using the images source method
    figure;
    subplot(211);
    plot(t,x);
    title("Emitted noise signal");
    x = complex_wave_ism(x,S1,R,L,t,Fs,Ts,thresh,spacing,c,Q,rho,order,alpha,geogebra);
    subplot(212);
    plot(t,x);
    title("Received noise signal");
    %LMS
    for i=M:N
        
        y(i) = w*x(i:-1:i-M+1)';
        % y needs to processed some more, as it (espacially initially)
        % consist of mostly zeros and thus will not consist of any
        % fundamental sine waves -> we strip the wave of all 0s
        if(~isempty(y(y ~= 0)))
            y_processed = y(y ~= 0);
        else
            y_processed = y;
        end
        
        % The pressure deviation caused by the signal emited by the secondary source S2 at the error
        % microphone is computed using the images source method
        y_ism = complex_wave_ism(y_processed,S2,R,L,t,Fs,Ts,thresh,spacing,c,Q,rho,order,alpha,geogebra);
        % Due to linearity the noise pressure deviation measured at the
        % error microphone is the sum of the to pressure signals (emitted
        % by S1 and S2)
        e=x+y_ism;
        w = w-2*mu*e(i)*x(i:-1:i-M+1);
    end
    
end