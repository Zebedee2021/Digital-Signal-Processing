% Zhou Zhiguo
% 2019.5.1
% Ch5 数字滤波器设计
% 脉冲响应不变变换法---impinvar 

% 说明：编程详细思路 -- 成型版

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% P194 教学demo
% 采用脉冲响应不变变换法，设计数字巴特沃斯滤波器
% 通带 Wp = 0.2*pi     1dB
% 阻带 Ws = 0.3~1*pi   15dB
% 求：N,H(z),H(ejw),直接-I
%--------------------------------------------------------------------------
T = 1;
fs = 1;
Wp = 0.2*pi; 
Ws = 0.3*pi;
Ap = 1;     %dB
As = 15;    %dB

%--------------------------------------------------------------------------
%模拟原型滤波器，采用freqs自动绘制幅频、相频图
%--------------------------------------------------------------------------
%[n,Wn] = buttord(Wp,Ws,Rp,Rs,'s') finds the minimum order n and cutoff frequencies Wn for an analog Butterworth filter. 
%Specify the frequencies Wp and Ws in radians per second. The passband or the stopband can be infinite.

[N,Wc] = buttord(Wp,Ws,Ap,As,'s'); %返回最小N和Wc，计算结果：Wc = 0.7087

%程序计算结果：Wc = 0.7087 满足阻带要求，给通带留裕量
%课本计算结果：Wc = 0.7032 满足通带要求，给阻带留裕量

[z,p,k] = buttap(N);          % Butterworth filter prototype
%p = 
%    -0.2588 + 0.9659i
%    -0.2588 - 0.9659i
%    -0.7071 + 0.7071i
%    -0.7071 - 0.7071i
%    -0.9659 + 0.2588i
%    -0.9659 - 0.2588i
%k = 1

%程序计算结果：H(s)=1/[s-(-0.2588 + 0.9659i)][s-(-0.2588 - 0.9659i)][s-(-0.7071 + 0.7071i)][s-(-0.7071 - 0.7071i)][s-(-0.9659 + 0.2588i)][s-(-0.9659 - 0.2588i)]
%------------>H(s)=1/(s^2 + 0.5176s + 1)(s^2 + 1.414s + 1)(s^2 + 1.9318s + 1)
%------------>H(s)=1/(s^6 + 3.8634*s^5 + 7.4634*s^4 + 9.1407*s^3 + 7.4634*s^2 + 3.8634*s + 1)
%可以用卷积计算 a=[1 0.5176 1]; b=[1 1.414 1]; c=[1 1.9318 1]
%hh=conv(a,b);hhh=conv(hh,c);
%hhh = 1.0000    3.8634    7.4634    9.1407    7.4634    3.8634    1.0000

%课本计算结果：H(s)=0.12093/(s^2 + 0.3640s + 0.4945)(s^2 + 0.9945s + 0.4945)(s^2 + 1.3585s + 0.4945)
%课本计算结果：H(s)=0.12093/(s^6 + 2.7170*s^5 + 3.6910*s^4 + 3.1789*s^3 + 1.8252*s^2 + 0.6644*s + 0.1209)
%用卷积计算a=[1 0.3640 0.4945];b=[1 0.9945 0.4945];c=[1 1.3585 0.4945]
%hh=conv(a,b);hhh=conv(hh,c);
%hhh = 1.0000    2.7170    3.6910    3.1789    1.8252    0.6644    0.1209
%
%Wn^1 = 0.7032^1 = 0.7032
%Wn^2 = 0.7032^2 = 0.4945
%Wn^3 = 0.7032^3 = 0.3477
%Wn^4 = 0.7032^4 = 0.2445
%Wn^5 = 0.7032^5 = 0.1719
%Wn^6 = 0.7032^6 = 0.1209
%
%表5-1计算结果：
%表5-1计算结果：H(s)=Wn^6/(s^6 + 3.863*Wn*s^5 + 7.464*Wn^2*s^4 + 9.141*Wn^3*s^3 + 7.464*Wn^4*s^2 + 3.863*Wn^5*s + Wn^6)
%表5-1计算结果：H(s)=0.1209/(s^6 + 2.7165*s^5 + 3.6909*s^4 + 3.1786*s^3 + 1.8251*s^2 + 0.6642*s + 0.1209)
%结论：课本计算结果 = 表5-1 

%课本计算结果： H(s)=0.12093/(s^6 + 2.7170*s^5 + 3.6910*s^4 + 3.1789*s^3 + 1.8252*s^2 + 0.6644*s + 0.1209)
%程序计算结果： H(s)=1/(s^6 + 3.8634*s^5 + 7.4634*s^4 + 9.1407*s^3 + 7.4634*s^2 + 3.8634*s + 1)
%表5-1计算结果：H(s)=Wn^6/(s^6 + 3.863*Wn*s^5 + 7.464*Wn^2*s^4 + 9.141*Wn^3*s^3 + 7.464*Wn^4*s^2 + 3.863*Wn^5*s + Wn^6)
%表5-1计算结果：H(s)=0.1209/(s^6 + 2.7165*s^5 + 3.6909*s^4 + 3.1786*s^3 + 1.8251*s^2 + 0.6642*s + 0.1209)
%结论：程序计算结果把Wn归一化了！！！

c_normalized = 0;
if c_normalized == 1
[num,den] = zp2tf(z,p,k);     % Convert to transfer function form
%num = 0         0         0         0         0         0         1
%den = 1.0000    3.8637    7.4641    9.1416    7.4641    3.8637    1.0000
else
%个人经验：
% [N,Wc] = buttord(Wp,Ws,Ap,As,'s');求得N和Wc；这个Wc不归一化；
% [z,p,k] = buttap(N);              求得零极点，但这个零极点是归一化的； 
% [num,den] = zp2tf(z,p,k);         求分子，分母系数前，零极点需要去归一化；
p = p*Wc;  %课本极点数值
[num,den] = zp2tf(z,p,k);     % Convert to transfer function form
num = num*(Wc^N);
%num = 0         0         0         0         0         0         0.1266
%den = 1.0000    2.7380    3.7484    3.2533    1.8824    0.6905    0.1266
end

figure(1);
W = logspace(-pi,pi);
freqs(num,den,W)                % Frequency response of analog filter

%--------------------------------------------------------------------------
%模拟原型滤波器，自行在freqs输出h,w基础上绘制幅频、相频图
%--------------------------------------------------------------------------
figure(2);
%w = logspace(-1, 1);       %scale:log 
w = logspace(-pi, pi);       %scale:log 
h = freqs(num,den,w);
mag = abs(h)/abs(h(1));
dbmag = 20*log10(mag);
phase = angle(h);           %输出scale:-pi~pi
degphase = phase*180/pi;    %转为degree
subplot(2,1,1), loglog(w,mag)
grid on;
xlabel('Frequency (rad/s)');
ylabel('Magnitude');
title('频率-幅度');
subplot(2,1,2), semilogx(w,degphase)
grid on;
xlabel('Frequency (rad/s)');
ylabel('Phase (degrees)');
title('频率-相位');

%--------------------------------------------------------------------------
%模拟原型滤波器，幅频 线性---对数 比较图
%--------------------------------------------------------------------------
figure(3);
subplot(2,1,1), loglog(w,mag)
grid on;
xlabel('Frequency (rad/s)');
ylabel('Magnitude');
title('频率-幅度');
subplot(2,1,2),  semilogx(w,dbmag)
grid on;
xlabel('Frequency (rad/s)');
ylabel('Magnitude （dB）');
title('频率-幅度 dB');

%--------------------------------------------------------------------------
%模拟滤波器设计
%和P196 图5-41指标一致，但图5-41是数字滤波器
%--------------------------------------------------------------------------
figure(4);
w = linspace(0, pi);        
h = freqs(num,den,w);
mag = abs(h)/abs(h(1));
dbmag = 20*log10(mag);
phase = angle(h);           %输出scale:-pi~pi
degphase = phase*180/pi;    %转为degree

subplot(3,1,1), plot(w/pi,mag)
grid on;
xlabel('Frequency (0~\pi)');
xticklabels({'0','0.1\pi','0.2\pi','0.3\pi','0.4\pi','0.5\pi','0.6\pi','0.7\pi','0.8\pi','0.9\pi','\pi'})
ylabel('Magnitude');
title('模拟滤波器 频率-幅度');
subplot(3,1,2), plot(w/pi,dbmag)
grid on;
xlabel('Frequency (0~\pi)');
xticklabels({'0','0.1\pi','0.2\pi','0.3\pi','0.4\pi','0.5\pi','0.6\pi','0.7\pi','0.8\pi','0.9\pi','\pi'})
ylabel('Magnitude （dB）');
title('模拟滤波器 频率-幅度 dB');
subplot(3,1,3), plot(w/pi,degphase)
grid on;
xlabel('Frequency (0~\pi)');
xticklabels({'0','0.1\pi','0.2\pi','0.3\pi','0.4\pi','0.5\pi','0.6\pi','0.7\pi','0.8\pi','0.9\pi','\pi'})
ylabel('Phase (degrees)');
title('模拟滤波器 频率-相位');

%--------------------------------------------------------------------------
%设计数字滤波器
%采用freqz自动绘制幅频、相频图
%--------------------------------------------------------------------------
figure(5);
[b,a] = butter(N,Wc/pi);  
%设计模拟滤波器。
%[___] = butter(___,'s') designs a lowpass, highpass, bandpass, or bandstop analog Butterworth filter with cutoff angular frequency Wn.

%B =      0         0         0         0         0         0    0.1266
%A = 1.0000    2.7380    3.7484    3.2533    1.8824    0.6905    0.1266

freqz(b,a);

%--------------------------------------------------------------------------
%自行在freqz输出h,基础上绘制幅频、相频图
%--------------------------------------------------------------------------
figure(8);
w = linspace(0,pi);       %scale:log 
h = freqz(b,a,w);
mag = abs(h)/abs(h(1));
dbmag = 20*log10(mag);
phase = angle(h);           %输出scale:-pi~pi
degphase = phase*180/pi;    %转为degree

subplot(3,1,1), plot(w,mag)
grid on;
xlabel('Frequency (rad/s)');
xlim([0 pi]);
xticks(0:0.1*pi:pi);
xticklabels({'0','0.1\pi','0.2\pi','0.3\pi','0.4\pi','0.5\pi','0.6\pi','0.7\pi','0.8\pi','0.9\pi','\pi'})
ylabel('Magnitude');
title('频率-幅度');

subplot(3,1,2), plot(w,dbmag)
grid on;
xlabel('Frequency (0~\pi)');
xlim([0 pi]);
xticks(0:0.1*pi:pi);
xticklabels({'0','0.1\pi','0.2\pi','0.3\pi','0.4\pi','0.5\pi','0.6\pi','0.7\pi','0.8\pi','0.9\pi','\pi'})
ylabel('Magnitude （dB）');
ylim([-80 0]);
title('数字滤波器 频率-幅度 dB');

subplot(3,1,3), plot(w,degphase)
grid on;
xlabel('Frequency (rad/s)');
xlim([0 pi]);
xticks(0:0.1*pi:pi);
xticklabels({'0','0.1\pi','0.2\pi','0.3\pi','0.4\pi','0.5\pi','0.6\pi','0.7\pi','0.8\pi','0.9\pi','\pi'})
ylabel('Phase (degrees)');
title('频率-相位');

%--------------------------------------------------------------------------
%设计数字滤波器
%采用脉冲响应不变变换法设计
%采用freqz自动绘制幅频、相频图
%--------------------------------------------------------------------------
figure(6);
[B,A] = butter(N,Wc,'s');
%这个是设计模拟滤波器。
%[___] = butter(___,'s') designs a lowpass, highpass, bandpass, or bandstop analog Butterworth filter with cutoff angular frequency Wn.
%B =      0         0         0         0         0         0    0.1266
%A = 1.0000    2.7380    3.7484    3.2533    1.8824    0.6905    0.1266

[D,C] = impinvar(B,A,fs); 

%[bz,az] = impinvar(b,a,fs) creates a digital filter with numerator and denominator coefficients bz and az, respectively, 
%whose impulse response is equal to the impulse response of the analog filter with coefficients b and a, scaled by 1/fs. 
%If you leave out the argument fs, or specify fs as the empty vector [], it takes the default value of 1 Hz.

%D = -0.0000    0.0007    0.0105    0.0167    0.0042    0.0001         0
%C = 1.0000   -3.3443    5.0183   -4.2190    2.0725   -0.5600    0.0647


freqz(D,C,1024,fs);

%B = 0         0         0         0         0         0         0.1266
%A = 1.0000    2.7380    3.7484    3.2533    1.8824    0.6905    0.1266

%num = 0         0         0         0         0         0         0.1266
%den = 1.0000    2.7380    3.7484    3.2533    1.8824    0.6905    0.1266

%--------------------------------------------------------------------------
%和P196 图5-41一样，数字滤波器
%--------------------------------------------------------------------------
figure(7);
W = linspace(0,pi);       
H = freqz(D,C,W);
mag = abs(H)/abs(H(1));
dbmag = 20*log10(mag);
phase = angle(H);           %输出scale:-pi~pi
degphase = phase*180/pi;    %转为degree

subplot(3,1,1), plot(W,abs(H))
grid on;
xlabel('Frequency (0~\pi)');
xlim([0 pi]);
xticks(0:0.1*pi:pi);
xticklabels({'0','0.1\pi','0.2\pi','0.3\pi','0.4\pi','0.5\pi','0.6\pi','0.7\pi','0.8\pi','0.9\pi','\pi'})
ylabel('Magnitude');
title('数字滤波器 频率-幅度');

subplot(3,1,2), plot(W,dbmag)
grid on;
xlabel('Frequency (0~\pi)');
xlim([0 pi]);
xticks(0:0.1*pi:pi);
xticklabels({'0','0.1\pi','0.2\pi','0.3\pi','0.4\pi','0.5\pi','0.6\pi','0.7\pi','0.8\pi','0.9\pi','\pi'})
ylabel('Magnitude （dB）');
title('数字滤波器 频率-幅度 dB');

subplot(3,1,3), plot(W,degphase)
grid on;
xlabel('Frequency (0~\pi)');
xlim([0 pi]);
xticks(0:0.1*pi:pi);
xticklabels({'0','0.1\pi','0.2\pi','0.3\pi','0.4\pi','0.5\pi','0.6\pi','0.7\pi','0.8\pi','0.9\pi','\pi'})
ylabel('Phase (degrees)');
title('数字滤波器 频率-相位');