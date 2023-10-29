%Zhou Zhiguo
%2019.5.2
%v1.0
% butter & Chebyshev ~ N
% butter^2 & Chebyshev^2 ~ N
clear; 
close all;
clc;

%-----------------------------------
% butter & Chebyshev ~ N
figure(1);
n = 4;    %4阶
str = ["N=4 巴特沃斯", "N=4 切比雪夫-I"];
%-----------------------------------
%巴特沃斯
[z, p, k]=buttap(n);
[num,den] = zp2tf(z,p,k);
w = linspace(0, pi);        
h = freqs(num,den,w);
mag = abs(h)/abs(h(1));
dbmag = 20*log10(mag);
phase = angle(h);           %输出scale:-pi~pi
degphase = phase*180/pi;    %转为degree
plot(w/pi,mag)
hold on;   
%-----------------------------------
%切比雪夫-I  注意I型分奇偶
Rp = 1; %3db 可设置

n = 1;
[z,p,k] = cheb1ap(n,Rp);       % Lowpass filter prototype
[num,den] = zp2tf(z,p,k);     % Convert to transfer function form
w = linspace(0, pi);        
h = freqs(num,den,w);
max_h = h(1);

n = 3;
[z,p,k] = cheb1ap(n,Rp);       % Lowpass filter prototype
[num,den] = zp2tf(z,p,k);     % Convert to transfer function form
w = linspace(0, pi);        
h = freqs(num,den,w);
mag = abs(h)/abs(max_h);
dbmag = 20*log10(mag);
phase = angle(h);           %输出scale:-pi~pi
degphase = phase*180/pi;    %转为degree
plot(w/pi,mag)

%-----------------------------------
xlabel('频率');
ylabel('振幅');
title('巴特沃斯/切比雪夫-I 滤波器振幅特性对阶次N的依赖关系')
grid on;
legend(str(1),str(2));
%-----------------------------------

%-----------------------------------
% butter^2 & Chebyshev^2 ~ N
figure(2);
n = 4;    %4阶
str = ["N=4 巴特沃斯", "N=4 切比雪夫-II"];
%-----------------------------------
%巴特沃斯^2
[z, p, k]=buttap(n);
[num,den] = zp2tf(z,p,k);
w = linspace(0, pi);        
h = freqs(num,den,w);
mag = abs(h)/abs(h(1));
mag_s = power(mag,2);
dbmag = 20*log10(mag_s);
phase = angle(h);           %输出scale:-pi~pi
degphase = phase*180/pi;    %转为degree
plot(w/pi,mag_s)
hold on;   
%-----------------------------------
%切比雪夫^2  注意I型分奇偶
n = 1;
[z,p,k] = cheb1ap(n,Rp);       % Lowpass filter prototype
[num,den] = zp2tf(z,p,k);     % Convert to transfer function form
w = linspace(0, pi);        
h = freqs(num,den,w);
max_h = h(1);

n = 3;
[z,p,k] = cheb1ap(n,Rp);       % Lowpass filter prototype
[num,den] = zp2tf(z,p,k);     % Convert to transfer function form
w = linspace(0, pi);        
h = freqs(num,den,w);
mag = abs(h)/abs(max_h);
mag_s = power(mag,2);
dbmag = 20*log10(mag_s);
phase = angle(h);           %输出scale:-pi~pi
degphase = phase*180/pi;    %转为degree
plot(w/pi,mag_s)

%-----------------------------------
xlabel('频率');
ylabel('振幅');
title('巴特沃斯/切比雪夫-II 滤波器振幅平方特性对阶次N的依赖关系')
grid on;
legend(str(1),str(2));
%-----------------------------------