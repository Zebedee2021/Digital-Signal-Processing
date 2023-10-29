% Zhou Zhiguo
% 2019.5.5
% ch5_filtord
% filtord --- Filter order

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/filtord.html
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% (1) Verify Order of FIR Filter
%--------------------------------------------------------------------------
% Design a 20th-order FIR filter with normalized cutoff frequency 0.5¦Ð rad/sample using the window method. 
% Verify the filter order.

b = fir1(20,0.5);
n = filtord(b);

% Design the same filter using designfilt and verify its order.
di = designfilt('lowpassfir','FilterOrder',20,'CutoffFrequency',0.5);
ni = filtord(di);

%--------------------------------------------------------------------------
% (2) Determine the Order Difference Between FIR and IIR Designs
%--------------------------------------------------------------------------
% Design FIR equiripple and IIR Butterworth filters from the same set of specifications. 
% Determine the difference in filter order between the two designs.

fir = designfilt('lowpassfir','DesignMethod','equiripple','SampleRate',1e3, ...
                 'PassbandFrequency',100,'StopbandFrequency',120, ...
                 'PassbandRipple',0.5,'StopbandAttenuation',60);
iir = designfilt('lowpassiir','DesignMethod','butter','SampleRate',1e3, ...
                 'PassbandFrequency',100,'StopbandFrequency',120, ...
                 'PassbandRipple',0.5,'StopbandAttenuation',60);
             
FIR = filtord(fir);
IIR = filtord(iir);

