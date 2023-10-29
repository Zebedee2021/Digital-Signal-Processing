% Zhou Zhiguo
% 2019.8.6
% Ch5 数字滤波器设计
% butter 巴特沃斯数字滤波器

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/butter.html#bucsinx
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% 低通
% Design a 6th-order lowpass Butterworth filter with a cutoff frequency of 300 Hz, 
% which, for data sampled at 1000 Hz, corresponds to 0.6π rad/sample. 
% Plot its magnitude and phase responses. Use it to filter a 1000-sample random signal.
%--------------------------------------------------------------------------
figure;
fc = 300;
fs = 1000;
[b,a] = butter(6,fc/(fs/2));
freqz(b,a);
dataIn = randn(1000,1);
dataOut = filter(b,a,dataIn);

%--------------------------------------------------------------------------
% 带阻
% Design a 6th-order Butterworth bandstop filter with normalized edge frequencies of 0.2π and 0.6π rad/sample. 
% Plot its magnitude and phase responses. Use it to filter random data.
%--------------------------------------------------------------------------
figure;
[b,a] = butter(3,[0.2 0.6],'stop');
freqz(b,a);
dataIn = randn(1000,1);
dataOut = filter(b,a,dataIn);

%--------------------------------------------------------------------------
% 高通
% Design a 9th-order highpass Butterworth filter. Specify a cutoff frequency of 300 Hz, 
% which, for data sampled at 1000 Hz, corresponds to 0.6π rad/sample. Plot the magnitude 
% and phase responses. Convert the zeros, poles, and gain to second-order sections for use by fvtool.
%--------------------------------------------------------------------------
[z,p,k] = butter(9,300/500,'high');
sos = zp2sos(z,p,k);
fvtool(sos,'Analysis','freq')

%--------------------------------------------------------------------------
% 带通
% Design a 20th-order Butterworth bandpass filter with a lower cutoff frequncy of 500 Hz 
% and a higher cutoff frequency of 560 Hz. Specify a sample rate of 1500 Hz.
% Use the state-space representation. Design an identical filter using designfilt.
%--------------------------------------------------------------------------
[A,B,C,D] = butter(10,[500 560]/750);
d = designfilt('bandpassiir','FilterOrder',20, ...
    'HalfPowerFrequency1',500,'HalfPowerFrequency2',560, ...
    'SampleRate',1500);

sos = ss2sos(A,B,C,D);
fvt = fvtool(sos,d,'Fs',1500);
legend(fvt,'butter','designfilt')


