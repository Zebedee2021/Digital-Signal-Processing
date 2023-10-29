% Zhou Zhiguo
% 2019.5.28
% test6
% Window-based FIR filter design 窗函数法
% h = [-0.0935    0.0000    0.1403   -0.0000   -0.1734   -0.0000    0.1854 
% -0.0000   -0.1734   -0.0000    0.1403    0.0000   -0.0935

clear; 
close all;
clc;

% rectwin
figure;
ord = 12;
h = fir1(ord,[0.4 0.6],'band',rectwin(ord+1));
freqz(h,1);
title('rectwin');

%--------------------------------------------------------------------------
% 说明：自行编程实现4种线性相位---幅度函数
%--------------------------------------------------------------------------
figure;
x = 0:2*pi/512:(2*pi-2*pi/512);%512点
subplot(2,1,1)
Hw1 = linear_phase_Hw_z(h);
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
Qw1 = linear_phase_Qw_z(h);
plot(x,Qw1);
xlabel('频率');
ylabel('Q(w)');
xlim([0 2*pi]);
ylim([-10*pi 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
yticks(-14*pi:2*pi:2*pi);
yticklabels({'-14\pi','-12\pi','-10\pi','-8\pi','-6\pi','-4\pi','-2\pi','0\pi','2\pi'});
title('Type 1');
grid on;