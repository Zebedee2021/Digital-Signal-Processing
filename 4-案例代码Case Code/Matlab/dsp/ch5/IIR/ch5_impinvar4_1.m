% Zhou Zhiguo
% 2019.5.1
% Ch5 数字滤波器设计
% 脉冲响应不变变换法---impinvar 
% 说明：模拟滤波器设计---详细计算过程

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

%H(s)=0.12093/(s^6 + 2.7170*s^5 + 3.6910*s^4 + 3.1789*s^3 + 1.8252*s^2 + 0.6644*s + 0.1209)

%------------------------------------------------------------------------
%Create zero-pole-gain model; convert to zero-pole-gain model
hs = tf(num,den);
zpk(hs);
pzmap(hs);

% ans =
% 
%                                  0.12665
% ------------------------------------------------------------------------
%  (s^2 + 1.369s + 0.5022) (s^2 + 1.002s + 0.5022) (s^2 + 0.3668s + 0.5022)
% 
% Continuous-time zero/pole/gain model.
%
%------------------------------------------------------------------------
%部分分式展开

%分子
Bs = num;
%分母
As = den;

[r,p,k] = residue(Bs,As);
disp(r);
disp(p);
disp(k);

% 留数
% r =
%    0.9351 - 1.6196i
%    0.9351 + 1.6196i
%    0.1447 + 0.2505i
%    0.1447 - 0.2505i
%   -1.0797 - 0.0000i
%   -1.0797 + 0.0000i
% 极点  
%  p =
%   -0.6845 + 0.1834i
%   -0.6845 - 0.1834i
%   -0.1834 + 0.6845i
%   -0.1834 - 0.6845i
%   -0.5011 + 0.5011i
%   -0.5011 - 0.5011i

%H(s) =     (0.9351 - 1.6196i)/[s-(-0.6845 + 0.1834i)] 
%         + (0.9351 + 1.6196i)/[s-(-0.6845 - 0.1834i)]
%         + (0.1447 + 0.2505i)/[s-(-0.1834 + 0.6845i)]
%         + (0.1447 - 0.2505i)/[s-(-0.1834 - 0.6845i)]
%         + (-1.0797 - 0.0000i)/[s-(-0.5011 + 0.5011i)]
%         + (-1.0797 + 0.0000i)/[s-(-0.5011 - 0.5011i)]
