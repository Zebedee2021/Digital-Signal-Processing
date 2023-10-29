%Zhou Zhiguo
%2019.4.22
%v1.0
% CZT
clear; 
close all;
clc;

%https://ww2.mathworks.cn/help/signal/ref/czt.html
%Use czt to zoom in on a narrow-band section of a filter's frequency response.
%Design a 30th-order lowpass FIR filter using the window method. 
%Specify a sample rate of 1 kHz and a cutoff frequency of 125 Hz. 
%Use a rectangular window. Find the transfer function of the filter.

fs = 1000;
d = designfilt('lowpassfir','FilterOrder',30,'CutoffFrequency',125, ...
    'DesignMethod','window','Window',@rectwin,'SampleRate',fs);
h = tf(d);

%Compute the DFT and the CZT of the filter. 
%Restrict the frequency range of the CZT to the band between 100 and 150 Hz. 
%Generate 1024 samples in each case.
m = 1024;
y = fft(h,m);

f1 = 100;
f2 = 150;
w = exp(-1i*2*pi*(f2-f1)/(m*fs));
a = exp(1i*2*pi*f1/fs);
z = czt(h,m,w,a);

%Plot the transforms. Zoom in on the area of interest.
fn = (0:m-1)'/m;
fy = fs*fn;
fz = (f2-f1)*fn + f1;

subplot(4,1,1);
plot(fy,abs(y));
title('FFT')

subplot(4,1,2);
stem(fy,abs(y));
axis([f1 f2 0 1.2]);
title('FFT')

subplot(4,1,3);
plot(fz,abs(z));
title('CZT')
xlabel('Frequency (Hz)')

subplot(4,1,4);
stem(fz,abs(z));
axis([f1 f2 0 1.2])
title('CZT')
xlabel('Frequency (Hz)')
