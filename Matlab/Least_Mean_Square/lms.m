%% AUTHOR    : https://www.eit.lth.se/fileadmin/eit/courses/ett042/CE/CE2e.pdf
function [e,w]=lms(mu,M,x,d);
% LMS returns the filter coefficients from the least-mean-square algorithm
%   [e,w] = LMS(mu,d,x) 
%   Eingabe 
%       mu      (1 x 1) step size
%       M       (1 x 1) filter length
%       d       (n x 1) reference signal
%       x       (n x 1) input signal
%       
%   Ausgabe 
%       e       (n x 1) estimation error
%       w       (M x 1) finatl filter coefficients
% 
    %inital values: 0
    w=zeros(M,1);
    %number of samples of the input signal
    N=length(x);
    %Make sure that u and d are column vectors
    x=x(:);
    d=d(:);
    %LMS
    for n=M:N
        xvec=x(n:-1:n-M+1);
        e(n)=d(n)-w'*xvec;
        w=w+mu*xvec*conj(e(n));
    end
    e=e(:);
end