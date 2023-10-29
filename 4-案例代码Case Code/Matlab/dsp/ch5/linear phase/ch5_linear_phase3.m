% Zhou Zhiguo
% 2019.4.26
% Ch5 数字滤波器设计
% 说明：自行编程实现4种线性相位幅度函数、相位函数

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% (1)
% https://ww2.mathworks.cn/help/dsp/ref/firtype.html?s_tid=doc_ta

% N指：序列长度
% case1：h(n)中心偶对称，N为奇数
% case2：h(n)中心偶对称，N为偶数
% case3：h(n)中心奇对称，N为奇数
% case4：h(n)中心奇对称，N为偶数

% N指：滤波器阶数，比课本序列长度小1
% Filter type, returned as either 1, 2, 3, or 4. Filter types are defined as follows:
% Type 1 — Even-order symmetric coefficients     h(n)偶对称，F偶数阶，N为奇数
% Type 2 — Odd-order symmetric coefficients      h(n)偶对称，F奇数阶，N为偶数
% Type 3 — Even-order antisymmetric coefficients h(n)奇对称，F偶数阶，N为奇数
% Type 4 — Odd-order antisymmetric coefficients  h(n)奇对称，F奇数阶，N为偶数
%--------------------------------------------------------------------------
figure;
%Type 1 — Even-order symmetric coefficients <=> case1：h(n)偶对称，F偶数阶，N为奇数   
subplot(2,1,1)
%h1 = fir1(8,0.5);
h1 = fir1(8,0.3);
impz(h1), title(['Type ' int2str(firtype(h1))])

% Type 2 — Odd-order symmetric coefficients <=> case2：h(n)偶对称，F奇数阶，N为偶数
subplot(2,1,2)
%h2 = fir1(9,0.5);
h2 = fir1(9,0.3);
impz(h2), title(['Type ' int2str(firtype(h2))])

% Type 3 — Even-order antisymmetric coefficients <=> case3：h(n)奇对称，F偶数阶，N为奇数
figure;
subplot(2,1,1)
h3 = firpm(8,[0.2 0.8],[1 1],'hilbert');
impz(h3), title(['Type ' int2str(firtype(h3))])

% Type 4 — Odd-order antisymmetric coefficients  <=> case4：h(n)奇对称，F奇数阶，N为偶数
subplot(2,1,2)
h4 = firpm(9,[0.2 0.8],[1 1],'hilbert');
impz(h4), title(['Type ' int2str(firtype(h4))])

%fvtool(h1);
%fvtool(h2);
%fvtool(h3);
%fvtool(h4);

%--------------------------------------------------------------------------
% (2)说明：自行编程实现4种线性相位---幅度函数
%--------------------------------------------------------------------------
figure;
x = 0:2*pi/512:(2*pi-2*pi/512);%512点

subplot(2,2,1)
Hw1 = linear_phase_Hw_z(h1);
plot(x,Hw1);
xlabel('频率');
ylabel('H(w)');
xlim([0 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
title('Type 1');
grid on;

subplot(2,2,2)
Hw2 = linear_phase_Hw_z(h2);
plot(x,Hw2);
xlabel('频率');
ylabel('H(w)');
xlim([0 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
title('Type 2');
grid on;

subplot(2,2,3)
Hw3 = linear_phase_Hw_z(h3);
plot(x,Hw3);
xlabel('频率');
ylabel('H(w)');
xlim([0 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
title('Type 3');
grid on;

subplot(2,2,4)
Hw4 = linear_phase_Hw_z(h4);
plot(x,Hw4);
xlabel('频率');
ylabel('H(w)');
xlim([0 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
title('Type 4');
grid on;

%--------------------------------------------------------------------------
% (3)说明：自行编程实现4种线性相位---幅频响应
%--------------------------------------------------------------------------
figure;
x = 0:2*pi/512:(2*pi-2*pi/512);%512点

subplot(2,2,1)
Hw1 = linear_phase_Hw_z(h1);
plot(x,abs(Hw1));
xlabel('频率');
ylabel('|X(e^j^\omega)|');
xlim([0 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
title('Type 1');
grid on;

subplot(2,2,2)
Hw2 = linear_phase_Hw_z(h2);
plot(x,abs(Hw2));
xlabel('频率');
ylabel('|X(e^j^\omega)|');
xlim([0 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
title('Type 2');
grid on;

subplot(2,2,3)
Hw3 = linear_phase_Hw_z(h3);
plot(x,abs(Hw3));
xlabel('频率');
ylabel('|X(e^j^\omega)|');
xlim([0 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
title('Type 3');
grid on;

subplot(2,2,4)
Hw4 = linear_phase_Hw_z(h4);
plot(x,abs(Hw4));
xlabel('频率');
ylabel('|X(e^j^\omega)|');
xlim([0 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
title('Type 4');
grid on;

%--------------------------------------------------------------------------
% （4）说明：自行编程实现4种线性相位---相位函数
%--------------------------------------------------------------------------
figure;
x = 0:2*pi/512:(2*pi-2*pi/512);%512点

subplot(2,2,1)
Qw1 = linear_phase_Qw_z(h1);
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

subplot(2,2,2)
Qw2 = linear_phase_Qw_z(h2);
plot(x,Qw2);
xlabel('频率');
ylabel('Q(w)');
xlim([0 2*pi]);
ylim([-10*pi 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
yticks(-8*pi:2*pi:2*pi);
yticklabels({'-8\pi','-6\pi','-4\pi','-2\pi','0\pi','2\pi'});
title('Type 2');
grid on;

subplot(2,2,3)
Qw3 = linear_phase_Qw_z(h3);
plot(x,Qw3);
xlabel('频率');
ylabel('Q(w)');
xlim([0 2*pi]);
ylim([-10*pi 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
yticks(-8*pi:2*pi:2*pi);
yticklabels({'-8\pi','-6\pi','-4\pi','-2\pi','0\pi','2\pi'});
title('Type 3');
grid on;

subplot(2,2,4)
Qw4 = linear_phase_Qw_z(h4);
plot(x,Qw4);
xlabel('频率');
ylabel('Q(w)');
xlim([0 2*pi]);
ylim([-10*pi 2*pi]);
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
yticks(-8*pi:2*pi:2*pi);
yticklabels({'-8\pi','-6\pi','-4\pi','-2\pi','0\pi','2\pi'});
title('Type 4');
grid on;

%--------------------------------------------------------------------------
% （5）说明：自行编程实现4种线性相位---幅频、相频响应
%--------------------------------------------------------------------------
% h1
figure;

K=512;
dw=2*pi/K;
k=0:511;
h = h1;
H = fft(h,512);

subplot(3,1,1);
stem(h);
%xlim([0 16]);
%ylim([-2 2]);
xlabel('序列号');
ylabel('序列值');
title('序列h(n)')

subplot(3,1,2);
plot(k*dw,abs(H));
plot(k*dw,abs(H));
xlim([0 2*pi]);
%ylim([0 10]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('幅值');
title('幅频响应|X(e^j^\omega)|');

subplot(3,1,3)
plot(k*dw,angle(H));
xlim([0 2*pi]);
ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}')

%--------------------------------------------------------------------------
% h2
figure;

K=512;
dw=2*pi/K;
k=0:511;
h = h2;
H = fft(h,512);

subplot(3,1,1);
stem(h);
%xlim([0 16]);
%ylim([-2 2]);
xlabel('序列号');
ylabel('序列值');
title('序列h(n)')

subplot(3,1,2);
plot(k*dw,abs(H));
plot(k*dw,abs(H));
xlim([0 2*pi]);
%ylim([0 10]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('幅值');
title('幅频响应|X(e^j^\omega)|');

subplot(3,1,3)
plot(k*dw,angle(H));
xlim([0 2*pi]);
ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}')

%--------------------------------------------------------------------------
% h3
figure;

K=512;
dw=2*pi/K;
k=0:511;
h = h3;
H = fft(h,512);

subplot(3,1,1);
stem(h);
%xlim([0 16]);
%ylim([-2 2]);
xlabel('序列号');
ylabel('序列值');
title('序列h(n)')

subplot(3,1,2);
plot(k*dw,abs(H));
plot(k*dw,abs(H));
xlim([0 2*pi]);
%ylim([0 10]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('幅值');
title('幅频响应|X(e^j^\omega)|');

subplot(3,1,3)
plot(k*dw,angle(H));
xlim([0 2*pi]);
ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}')

%--------------------------------------------------------------------------
% h4
figure;

K=512;
dw=2*pi/K;
k=0:511;
h = h4;
H = fft(h,512);

subplot(3,1,1);
stem(h);
%xlim([0 16]);
%ylim([-2 2]);
xlabel('序列号');
ylabel('序列值');
title('序列h(n)')

subplot(3,1,2);
plot(k*dw,abs(H));
xlim([0 2*pi]);
%ylim([0 10]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('幅值');
title('幅频响应|X(e^j^\omega)|');

subplot(3,1,3)
plot(k*dw,angle(H));
xlim([0 2*pi]);
ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}')

