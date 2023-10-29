% Zhou Zhiguo
% 2019.5.5
% ch5_fir_frequency1
% Frequency sampling-based FIR filter design 频率取样法

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/fir2.html?searchHighlight=fir2&s_tid=doc_srchtitle
%--------------------------------------------------------------------------

clear; 
close all;
clc;
%--------------------------------------------------------------------------
% Attenuation of Low Frequencies
% Load the MAT-file chirp. The file contains a signal, y, sampled at a frequency Fs = 8192Hz. 
% y has most of its power above , or half the Nyquist frequency. Add random noise to the signal.
%--------------------------------------------------------------------------
load chirp
y = y + 0.25*(rand(size(y))-0.5);

%--------------------------------------------------------------------------
% Design a 34th-order FIR highpass filter to attenuate the components of the signal below Fs/4. 
% Specify a cutoff frequency of 0.48. Visualize the frequency response of the filter.
%--------------------------------------------------------------------------
figure;
f = [0 0.48 0.48 1];
mhi = [0 0 1 1];
bhi = fir2(34,f,mhi);

freqz(bhi,1);

%--------------------------------------------------------------------------
% Filter the chirp signal. Plot the signal before and after filtering.
%--------------------------------------------------------------------------
figure;
outhi = filter(bhi,1,y);
t = (0:length(y)-1)/Fs;

subplot(2,1,1);
plot(t,y);
title('Original Signal');
ylim([-1.2 1.2]);

subplot(2,1,2);
plot(t,outhi);
title('Higpass Filtered Signal');
xlabel('Time (s)');
ylim([-1.2 1.2]);

%--------------------------------------------------------------------------
% Change the filter from highpass to lowpass. Use the same order and cutoff. 
% Filter the signal again. The result is mostly noise.
%--------------------------------------------------------------------------
figure;
mlo = [1 1 0 0];
blo = fir2(34,f,mlo);
outlo = filter(blo,1,y);

subplot(2,1,1);
plot(t,y);
title('Original Signal');
ylim([-1.2 1.2]);

subplot(2,1,2);
plot(t,outlo);
title('Lowpass Filtered Signal');
xlabel('Time (s)');
ylim([-1.2 1.2]);

%--------------------------------------------------------------------------
% FIR Lowpass Filter
% Design a 30th-order lowpass filter with a normalized cutoff frequency of 0.6π rad/sample. 
% Plot the ideal frequency response overlaid with the actual frequency response.
%--------------------------------------------------------------------------
figure;
f = [0 0.6 0.6 1];
m = [1 1 0 0];

b1 = fir2(30,f,m);
[h1,w] = freqz(b1,1);

plot(f,m,w/pi,abs(h1));
xlabel('\omega / \pi');
lgs = {'Ideal','fir2 default'};
legend(lgs);

%--------------------------------------------------------------------------
% Redesign the filter using a 64-point interpolation grid.
%--------------------------------------------------------------------------
b2 = fir2(30,f,m,64);
h2 = freqz(b2,1);

hold on
plot(w/pi,abs(h2));
lgs{3} = 'npt = 64';
legend(lgs);

%--------------------------------------------------------------------------
% Redesign the filter using the 64-point interpolation grid and a 13-point interval around the cutoff frequency.
%--------------------------------------------------------------------------
b3 = fir2(30,f,m,64,13);
h3 = freqz(b3,1);

plot(w/pi,abs(h3));
lgs{4} = 'lap = 13';
legend(lgs);
