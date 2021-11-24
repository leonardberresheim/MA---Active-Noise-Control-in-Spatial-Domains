%% AUTHOR    : Leonard Berresheim
function [e,y]=lms(mu,M,x,d)
% LMS returns the filter coefficients from the least-mean-square algorithm
%   [e,y] = LMS(mu,d,x) 
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
    N=length(x);
    %inital values: 0
    w=zeros(1,M);
    y = zeros(1,N);

    %number of samples of the input signal
    
    %LMS
    for i=M:N
        y(i) = w*x(i:-1:i-M+1)';
        e(i)=x(i)+y(i);
        w = w-2*mu*e(i)*x(i:-1:i-M+1);
    end
    
end