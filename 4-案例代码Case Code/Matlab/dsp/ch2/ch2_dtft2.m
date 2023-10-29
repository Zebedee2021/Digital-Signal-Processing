% Zhou Zhiguo
% 2019.4.16
% v1.0
% DTFT 采用FFT计算
clear; 
close all;

%x(t)采用f为单位
fs = 16;%Hz
f1 = 1; %Hz
f2 = 2; %Hz
N = 16;
n = 0:1:15;
dt = 0.001;   %仿真步长：0.001s
t = 0:dt:1;  %仿真时长：2s，建议设置为2个周期即可
xt = sin(2*pi*f1*t) + cos(2*pi*f2*t); %周期T=2pi/w 1,1/2,组合波形周期为1；

figure('Name','ch2_DTFT2','NumberTitle','off');
%---------------------------------------------------------
%数字序列图
%---------------------------------------------------------
subplot(3,1,1);
x = sin(2*pi*(f1/fs)*n)+cos(4*pi*(f1/fs)*n);
stem(n,x);
xlim([0 16]);
ylim([-2 2]);
xlabel('序列号');
ylabel('序列值');
title('序列x(n)')
%增加轮廓线，便于观察；取样频率10Hz，取样间隔0.1s
hold on;
plot(t*16,xt,'red');
%---------------------------------------------------------
%序列DTFT图
%---------------------------------------------------------
K=512;
dw=2*pi/K;
k=0:511;
%X=x*exp(-1i*dw*n'*k);
X=fft(x,K);
subplot(3,1,2);
%plot(k*dw,abs(X));
plot(k*dw,abs(X));
xlim([0 2*pi]);
ylim([0 10]);
xlabel('数字频率 0~2\pi');
ylabel('幅值');
title('幅频响应|X(e^j^\omega)|');
%---------------------------------------------------------
subplot(3,1,3);
plot(k*dw,angle(X));
xlim([0 2*pi]);
ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}')
