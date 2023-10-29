% Zhou Zhiguo
% 2019.8.6
% ch5_conv_filter
clear; 
close all;
clc;

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ug/filter-implementation-and-analysis.html
%--------------------------------------------------------------------------
x = randn(1,5);
h = [1 1 1 1];   
y1 = conv(h,x);

b = [1 1 1 1];
a = 1;
y2 = filter(b,a,x);

%IIR
x = randn(1,5);
h = [1 1]/4;	% A third-order filter has length 4 
y_l = conv(h,x);
y_c = cconv(h,x);

%ÐèÒª²¹Áã¶ÔÆë
x_2 = [x,0];
b = [1 1]/4;
a = 1;
y_2 = filter(b,a,x_2);

disp(x);
disp(y_l);
disp(y_c);
disp(y_2);
% b = 1;
% a = [1 -0.9];
% y = filter(b,a,x);