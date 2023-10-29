% Zhou Zhiguo
% 2019.5.5
% ch5_designfilt
% 说明：采用designfilt函数设计，得到滤波器对象

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/designfilt.html
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% (1) Lowpass FIR filter
%--------------------------------------------------------------------------

lpFilt = designfilt('lowpassfir','PassbandFrequency',0.25, ...
         'StopbandFrequency',0.35,'PassbandRipple',0.5, ...
         'StopbandAttenuation',65,'DesignMethod','kaiserwin');
fvtool(lpFilt)

dataIn = rand(1000,1);
dataOut = filter(lpFilt,dataIn);

%--------------------------------------------------------------------------
% (2) Lowpass IIR filter
%--------------------------------------------------------------------------
lpFilt = designfilt('lowpassiir','FilterOrder',8, ...
         'PassbandFrequency',35e3,'PassbandRipple',0.2, ...
         'SampleRate',200e3);
fvtool(lpFilt)

dataIn = randn(1000,1);
dataOut = filter(lpFilt,dataIn);

sos = lpFilt.Coefficients;

