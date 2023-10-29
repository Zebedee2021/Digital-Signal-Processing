%Zhou Zhiguo
%2019.4.21
%v1.0
%ÏßÐÔ¾í»ý¡¢Ô²ÖÜ¾í»ý
clear; 
close all;
clc;

% https://ww2.mathworks.cn/help/signal/ref/cconv.html
a = [1 2 -1 1];
b = [1 1 2 1 2 2 1 1];
c = cconv(a,b);            % Circular convolution
cref = conv(a,b);          % Linear convolution

% ¿Î¼þ
u = [0 1 2 1 0];
v = [0 1 0 1 0];
Lconv = conv(u,v);
Cconv_5 = cconv(u,v,5);
Cconv_10 = cconv(u,v,10);
x = circshift(u,2);  %Ñ­»·ÓÒÒÆ2  x=u((n-2));
y = circshift(u,-2); %Ñ­»·×óÒÆ2  y=u((n+2));

%Õ¹Ê¾
subplot(4,2,1);
stem(u);
xlabel('ÐòºÅ');
ylabel('u(n)');

subplot(4,2,2);
stem(v);
xlabel('ÐòºÅ');
ylabel('v(n)');

subplot(4,2,[3, 4]);
stem(Lconv);
xlabel('ÐòºÅ');
ylabel('Lconv');
xlim([0 10]);

subplot(4,2,[5, 6]);
stem(Cconv_5);
xlabel('ÐòºÅ');
ylabel('Cconv_5');
xlim([0 10]);

subplot(4,2,[7, 8]);
stem(Cconv_10);
xlabel('ÐòºÅ');
ylabel('Cconv_10');
xlim([0 10]);
