%Zhou Zhiguo
%2019.4.17
%v1.0
%ZF 
clear; 
close all;

%定义系统
b=[0 1 0.5];
a=[1 -1 0.5];
%绘制零极点图
subplot(2,2,[1, 2]);
zplane(b, a);
title('$Pole-zero\;plot$', 'Interpreter', 'LaTex');
xlabel('$Real\;part$', 'Interpreter', 'LaTex')
ylabel('$Imaginary\;part$', 'Interpreter', 'LaTex');
%绘制频率响应幅度谱
[H, w] = freqz(b, a, 1000, 'whole');
subplot(223);
plot(w, abs(H));
axis([0 2*pi 0 5]);
title('$|H(e^{j\omega})|$', 'Interpreter', 'LaTex');
ylabel('$Magnitude$', 'Interpreter', 'LaTex')
xlabel('$\omega$', 'Interpreter', 'LaTex');
subplot(224);
%绘制频率响应相位谱
plot(w, unwrap(angle(H)));
title('$\Phi(\omega)_{unwrap}$', 'Interpreter', 'LaTex');
ylabel('$Phase$', 'Interpreter', 'LaTex')
xlabel('$\omega$', 'Interpreter', 'LaTex');
