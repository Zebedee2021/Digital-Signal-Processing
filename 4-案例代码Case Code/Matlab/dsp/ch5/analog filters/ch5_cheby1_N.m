% Zhou Zhiguo
% 2019.8.6
% Ch5 数字滤波器设计
% Chebyshev Type I filter 滤波器振幅特性对阶数N的依赖关系

clear; 
close all;
clc;

figure;
N = 6;
str = ["N=1","N=2","N=3","N=4","N=5","N=6"];
for n = 1:N
    [z,p,k] = cheb1ap(n,3);       % Lowpass filter prototype
    [num,den] = zp2tf(z,p,k);     % Convert to transfer function form

    w = linspace(0, pi);        
    h = freqs(num,den,w);
    
    %注意N为偶数时，h(0)小于1
    if n == 1
    max_h = h(1);
    end
    mag = abs(h)/abs(max_h);
    
    dbmag = 20*log10(mag);
    phase = angle(h);           %输出scale:-pi~pi
    degphase = phase*180/pi;    %转为degree

    plot(w/pi,mag)
    xlabel('频率');
    ylabel('振幅');
    title('切比雪夫-I 滤波器振幅特性对阶数N的依赖关系')
    grid on;
    hold on;
    
end
legend(str(1),str(2),str(3),str(4),str(5),str(6));
