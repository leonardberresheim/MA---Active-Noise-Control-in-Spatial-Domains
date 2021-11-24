clc;
close all;
clear all;
t=0.001:0.001:1;
d=0*t;%sin(2*pi*50*t);
figure;M=100;
plot(d);N=numel(d);
x=1*sin(2*pi*50*t);
w=zeros(1,M);wi=zeros(1,M);
y=zeros(N,1);
e=[];mu=0.0001;% u is taken small to ensure that the algorithm converges
for i=M:N
    y(i) = wi*x(i:-1:i-M+1)';
    e(i)=x(i)+y(i);
    wi = wi-2*mu*e(i)*x(i:-1:i-M+1);
end

ee=y'+x;
subplot(4,1,1),plot(d);title('desired signal');
subplot(4,1,2),plot(x);title('signal corrupted with noise');
subplot(4,1,3),plot(y);title('estimated signal');
subplot(4,1,4),plot(ee);title('error signal');

