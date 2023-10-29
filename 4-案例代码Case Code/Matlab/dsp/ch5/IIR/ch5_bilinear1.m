% Zhou Zhiguo
% 2019.4.21
% Ch5 数字滤波器设计
% 双线性变换法---bilinear

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/bilinear.html?s_tid=doc_ta
%Design the prototype for a 10th-order Chebyshev type I bandpass filter 
%with 3 dB of ripple in the passband. Convert it to state-space form.
%--------------------------------------------------------------------------
[z,p,k] = cheb1ap(10,3);
[A,B,C,D] = zp2ss(z,p,k);  

%--------------------------------------------------------------------------
%Create an analog filter with sample rate fs=2k
% prewarped band edges u1 u2 in rad/s
% bandwidth BW = u2 - u1
% and center frequency W0=squal(u1*u2)
% for use with lp2bp. Specify the passband edge frequencies as 100 Hz and 500 Hz.
%--------------------------------------------------------------------------

Fs = 2e3;
u1 = 2*Fs*tan(100*(2*pi/Fs)/2);   
u2 = 2*Fs*tan(500*(2*pi/Fs)/2); 
Bw = u2 - u1;                     
Wo = sqrt(u1*u2);                 
[At,Bt,Ct,Dt] = lp2bp(A,B,C,D,Wo,Bw);
[b,a] = ss2tf(At,Bt,Ct,Dt);        

%--------------------------------------------------------------------------
%Calculate the frequency response of the analog filter using freqs. 
%Plot the magnitude response and the prewarped frequency band edges.
%--------------------------------------------------------------------------
[h,w] = freqs(b,a);     
plot(w,mag2db(abs(h)))
hold on
ylim([-165 5])
[U1,U2] = meshgrid([u1 u2],ylim);
plot(U1,U2)
legend('Magnitude response','Lower Passband Edge','Upper Passband Edge')
hold off
xlabel('Angular Frequency (rad/s)')
ylabel('Magnitude (dB)')
grid

[Ad,Bd,Cd,Dd] = bilinear(At,Bt,Ct,Dt,Fs);

[bz,az] = ss2tf(Ad,Bd,Cd,Dd);

fvtool(bz,az,'Fs',Fs)
