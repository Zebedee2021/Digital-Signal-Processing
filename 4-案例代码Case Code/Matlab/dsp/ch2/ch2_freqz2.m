%Zhou Zhiguo
%2019.8.6
%v1.0
%ch2 
clear; 
close all;
clc;
%---------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/freqz.html?searchHighlight=freqz&s_tid=doc_srchtitle
%---------------------------------------------------------

%Express the numerator and denominator as polynomial convolutions. 
%Find the frequency response at 2001 points spanning the complete unit circle.
b0 = 0.05634;
b1 = [1  1];
b2 = [1 -1.0166 1];
a1 = [1 -0.683];
a2 = [1 -1.4461 0.7957];

b = b0*conv(b1,b2); % 多项式相乘，就是卷积！
a = conv(a1,a2);

[h,w] = freqz(b,a,'whole',2001);

%Plot the magnitude response expressed in decibels.
%绘制幅频图
figure;
%subplot(3,1,1);
plot(w/pi,20*log10(abs(h)));
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');

%Plot the phase response expressed in decibels.
%绘制相频图
figure;
%subplot(3,1,2);
plot(w/pi,angle(h));
ax = gca;
ax.YLim = [-pi pi];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase)');

%绘制零极点图
figure;
%subplot(3,1,3);
zplane(b, a);
title('$Pole-zero\;plot$', 'Interpreter', 'LaTex');
xlabel('$Real\;part$', 'Interpreter', 'LaTex')
ylabel('$Imaginary\;part$', 'Interpreter', 'LaTex');