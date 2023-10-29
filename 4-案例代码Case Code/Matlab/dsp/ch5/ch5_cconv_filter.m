% Zhou Zhiguo
% 2019.5.9
% ch5_cconv_filter
clear; 
close all;
clc;

a = [1 2 -1 1];
b = [1 1 2 1 2 2 1 1];
%l = conv(a,b);
c = cconv(a,b); % Circular convolution
cref = conv(a,b); % Linear convolution
dif = norm(c-cref);