% Zhou Zhiguo
% 2019.5.5
% ch5_fir_window1
% Window-based FIR filter design 窗函数法

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/fir1.html
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% (1) FIR Bandpass filter
% Design a 48th-order FIR bandpass filter with passband 0.35π≤ω≤0.65π rad/sample.
% Visualize its magnitude and phase responses.
%--------------------------------------------------------------------------
% hamming window 缺省值
figure;
b = fir1(48,[0.35 0.65]); % N = 49, h(n) = b
freqz(b,1,512);
grid on;
title('hamming window');

% rectwin
figure;
ord = 48;
b = fir1(ord,[0.35 0.65],rectwin(ord+1));
freqz(b,1,512);
grid on;
title('rectwin');
%--------------------------------------------------------------------------
% (2) FIR Highpass filter
% Load chirp.mat. The file contains a signal, y, that has most of its power above Fs/4, 
% or half the Nyquist frequency. The sample rate is 8192 Hz.
% Design a 34th-order FIR highpass filter to attenuate the components of the signal below Fs/4. 
% Use a cutoff frequency of 0.48 and a Chebyshev window with 30 dB of ripple.
%--------------------------------------------------------------------------
% Chebyshev window
figure;
load chirp
t = (0:length(y)-1)/Fs;
bhi = fir1(34,0.48,'high',chebwin(35,30));
freqz(bhi,1);
title('Chebyshev window');

% rectwin
figure;
ord = 34;
load chirp
t = (0:length(y)-1)/Fs;
bhi = fir1(ord,0.48,'high',rectwin(ord+1));
freqz(bhi,1);
title('rectwin');
%--------------------------------------------------------------------------
% Filter the signal. Display the original and highpass-filtered signals. Use the same y-axis scale for both plots.
%--------------------------------------------------------------------------
figure;
outhi = filter(bhi,1,y);

subplot(2,1,1);
plot(t,y);
title('Original Signal');
ys = ylim;

subplot(2,1,2);
plot(t,outhi);
title('Highpass Filtered Signal');
xlabel('Time (s)');
ylim(ys);

%--------------------------------------------------------------------------
% Design a lowpass filter with the same specifications. Filter the signal and compare the result to the original. 
% Use the same y-axis scale for both plots.
%--------------------------------------------------------------------------
figure;

blo = fir1(34,0.48,chebwin(35,30));
outlo = filter(blo,1,y);

subplot(2,1,1);
plot(t,y);
title('Original Signal');
ys = ylim;

subplot(2,1,2);
plot(t,outlo);
title('Lowpass Filtered Signal');
xlabel('Time (s)');
ylim(ys);