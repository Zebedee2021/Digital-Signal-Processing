% Zhou Zhiguo
% 2019.4.26
% Ch5 数字滤波器设计
% unwrap 相位平滑 不能替代H(w),Q(w)，不一样
% 说明：自行编程实现4种线性相位幅度函数、相位函数
% 采用PPT课件h(n)

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% (1) https://ww2.mathworks.cn/help/dsp/ref/firtype.html?s_tid=doc_ta
%--------------------------------------------------------------------------
figure;
%Type 1 — Even-order symmetric coefficients <=> case1：h(n)偶对称，F偶数阶，N为奇数   
subplot(2,1,1)
%h1 = fir1(8,0.3);
%h1 = [1 2 3 4 3 2 1];
h1 = [0.5 1 -1.5 2 -1.5 1 0.5];
impz(h1), title(['Type ' int2str(firtype(h1))])

% Type 2 — Odd-order symmetric coefficients <=> case2：h(n)偶对称，F奇数阶，N为偶数
subplot(2,1,2)
%h2 = fir1(9,0.3);
h2 = [0 0.5 1 -1 -1 1 0.5 0];
impz(h2), title(['Type ' int2str(firtype(h2))])

% Type 3 — Even-order antisymmetric coefficients <=> case3：h(n)奇对称，F偶数阶，N为奇数
figure;
subplot(2,1,1)
%h3 = firpm(8,[0.2 0.8],[1 1],'hilbert');
h3 = [0 0.5 1 -1.5 0 1.5 -1 -0.5 0];
impz(h3), title(['Type ' int2str(firtype(h3))])

% Type 4 — Odd-order antisymmetric coefficients  <=> case4：h(n)奇对称，F奇数阶，N为偶数
subplot(2,1,2)
%h4 = firpm(9,[0.2 0.8],[1 1],'hilbert');
h4 = [0 0.5 1 -1.5 1.5 -1 -0.5 0];
impz(h4), title(['Type ' int2str(firtype(h4))])

%--------------------------------------------------------------------------
% （5）说明：自行编程实现4种线性相位---幅频、相频响应
%--------------------------------------------------------------------------
% h1
figure;

K=512;
dw=2*pi/K;
k=0:(K-1);
h = h1;
H = fft(h,K);

subplot(4,1,1);
stem(h);
%xlim([0 16]);
%ylim([-2 2]);
xlabel('序列号');
ylabel('序列值');
title('序列h(n)')

subplot(4,1,2);
plot(k*dw,abs(H));
plot(k*dw,abs(H));
xlim([0 2*pi]);
%ylim([0 10]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('幅值');
title('幅频响应|X(e^j^\omega)|');

subplot(4,1,3)
plot(k*dw,angle(H));
xlim([0 2*pi]);
ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}')

subplot(4,1,4)
H_unwrap = unwrap(angle(H));
plot(k*dw,H_unwrap);
%plot(k*dw,angle(H));
xlim([0 2*pi]);
%ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}---平滑')
%--------------------------------------------------------------------------
% h2
figure;

K=512;
dw=2*pi/K;
k=0:(K-1);
h = h2;
H = fft(h,K);

subplot(4,1,1);
stem(h);
%xlim([0 16]);
%ylim([-2 2]);
xlabel('序列号');
ylabel('序列值');
title('序列h(n)')

subplot(4,1,2);
plot(k*dw,abs(H));
plot(k*dw,abs(H));
xlim([0 2*pi]);
%ylim([0 10]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('幅值');
title('幅频响应|X(e^j^\omega)|');

subplot(4,1,3)
plot(k*dw,angle(H));
xlim([0 2*pi]);
ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}')

subplot(4,1,4)
H_unwrap = unwrap(angle(H));
plot(k*dw,H_unwrap);
%plot(k*dw,angle(H));
xlim([0 2*pi]);
%ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}---平滑')
%--------------------------------------------------------------------------
% h3
figure;

K=512;
dw=2*pi/K;
k=0:(K-1);
h = h3;
H = fft(h,K);

subplot(4,1,1);
stem(h);
%xlim([0 16]);
%ylim([-2 2]);
xlabel('序列号');
ylabel('序列值');
title('序列h(n)')

subplot(4,1,2);
plot(k*dw,abs(H));
plot(k*dw,abs(H));
xlim([0 2*pi]);
%ylim([0 10]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('幅值');
title('幅频响应|X(e^j^\omega)|');

subplot(4,1,3)
plot(k*dw,angle(H));
xlim([0 2*pi]);
ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}')

subplot(4,1,4)
H_unwrap = unwrap(angle(H));
plot(k*dw,H_unwrap);
%plot(k*dw,angle(H));
xlim([0 2*pi]);
%ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}---平滑')
%--------------------------------------------------------------------------
% h4
figure;

K=512;
dw=2*pi/K;
k=0:(K-1);
h = h4;
H = fft(h,K);

subplot(4,1,1);
stem(h);
%xlim([0 16]);
%ylim([-2 2]);
xlabel('序列号');
ylabel('序列值');
title('序列h(n)')

subplot(4,1,2);
plot(k*dw,abs(H));
xlim([0 2*pi]);
%ylim([0 10]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('幅值');
title('幅频响应|X(e^j^\omega)|');

subplot(4,1,3)
plot(k*dw,angle(H));
xlim([0 2*pi]);
ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}')

subplot(4,1,4)
H_unwrap = unwrap(angle(H));
plot(k*dw,H_unwrap);
%plot(k*dw,angle(H));
xlim([0 2*pi]);
%ylim([-pi pi]);
xlabel('数字频率 0~2\pi');
xticks(0:0.5*pi:2*pi);
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'});
ylabel('相位');
title('相频响应 arg{X(e^j^\omega)}---平滑')
