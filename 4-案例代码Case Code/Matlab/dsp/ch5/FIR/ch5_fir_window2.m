% Zhou Zhiguo
% 2019.5.5
% ch5_fir_window1
% Window-based FIR filter design 窗函数法
% PPT 例题 

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% (1) FIR Lowpass filter
% Design a 20th-order FIR Lowpass filter with passband 0≤ω≤0.5π rad/sample.
% Visualize its magnitude and phase responses.
%--------------------------------------------------------------------------
% rectwin
figure;
ord = 20;
b = fir1(ord,0.5,'low',rectwin(ord+1));
h1 = b;
freqz(b,1,512);
grid on;
title('rectwin');
fvtool(b,1);
Hz = filt(b,1);

%--------------------------------------------------------------------------
% 说明：自行编程实现4种线性相位---幅度函数
%--------------------------------------------------------------------------
figure;
x = 0:2*pi/512:(2*pi-2*pi/512);%512点
subplot(2,1,1)
Hw1 = linear_phase_Hw_z(h1);
plot(x,Hw1);
xlabel('频率');
ylabel('H(w)');
xlim([0 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
title('Type 1');
grid on;

%--------------------------------------------------------------------------
% 说明：自行编程实现4种线性相位---相位函数
%--------------------------------------------------------------------------
subplot(2,1,2)
Qw1 = linear_phase_Qw_z(h1);
plot(x,Qw1);
xlabel('频率');
ylabel('Q(w)');
xlim([0 2*pi]);
ylim([-22*pi 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
yticks(-22*pi:4*pi:2*pi);
yticklabels({'-22\pi','-18\pi','-14\pi','-10\pi','-6\pi','-2\pi','0\pi','2\pi'});
title('Type 1');
grid on;

%--------------------------------------------------------------------------
% (2) FIR Highpass filter
% Design a 10th-order FIR Highpass filter with passband 0.5π≤ω rad/sample.
% Visualize its magnitude and phase responses.
%--------------------------------------------------------------------------
% rectwin
figure;
ord = 10;
b = fir1(ord,0.5,'High',rectwin(ord+1));
h2 = b;
freqz(b,1,512);
grid on;
title('rectwin');
fvtool(b,1);
Hz = filt(b,1);

%--------------------------------------------------------------------------
% 说明：自行编程实现4种线性相位---幅度函数
%--------------------------------------------------------------------------
figure;
x = 0:2*pi/512:(2*pi-2*pi/512);%512点
subplot(2,1,1)
Hw1 = linear_phase_Hw_z(h2);
plot(x,Hw1);
xlabel('频率');
ylabel('H(w)');
xlim([0 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
title('Type 1');
grid on;

%--------------------------------------------------------------------------
% 说明：自行编程实现4种线性相位---相位函数
%--------------------------------------------------------------------------
subplot(2,1,2)
Qw1 = linear_phase_Qw_z(h2);
plot(x,Qw1);
xlabel('频率');
ylabel('Q(w)');
xlim([0 2*pi]);
ylim([-10*pi 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
yticks(-8*pi:2*pi:2*pi);
yticklabels({'-8\pi','-6\pi','-4\pi','-2\pi','0\pi','2\pi'});
title('Type 1');
grid on;