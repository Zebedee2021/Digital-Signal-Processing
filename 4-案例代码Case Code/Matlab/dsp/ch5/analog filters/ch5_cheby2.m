% Zhou Zhiguo
% 2019.5.2
% Ch5 数字滤波器设计
% Chebyshev Type II filter design

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/cheby2.html

% Design a 6th-order lowpass Chebyshev Type II filter with 10 dB of passband ripple and 
%a passband edge frequency of 300 Hz, which, for data sampled at 1000 Hz, corresponds to 0.6π rad/sample. 
%Plot its magnitude and phase responses. Use it to filter a 1000-sample random signal.
%--------------------------------------------------------------------------
figure(1);
[b,a] = cheby2(6,10,0.6);
freqz(b,a);


%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/cheb2ap.html

%Design a 6th-order Chebyshev Type II analog lowpass filter with 3 dB of ripple in the passband. 
%Display its magnitude and phase responses.

%在官网程序基础上叠加显示，幅度是dB显示，分辨度不太高
%--------------------------------------------------------------------------
figure(2);
N = 6;
for n = 1:N
    [z,p,k] = cheb2ap(n,3);       % Lowpass filter prototype
    [num,den] = zp2tf(z,p,k);     % Convert to transfer function form
    freqs(num,den)                % Frequency response of analog filter
       
    W = logspace(-1,1);
    freqs(num,den,W)                % Frequency response of analog filter
    hold on;
    
    disp(n);
    disp(num);
    disp(den);
end
str = ["N=1","N=2","N=3","N=4","N=5","N=6"];
legend(str(1),str(2),str(3),str(4),str(5),str(6));

%--------------------------------------------------------------------------
%自己写程序，幅度是线性显示，提高分辨度
%--------------------------------------------------------------------------
figure(3);
N = 6;
str = ["N=1","N=2","N=3","N=4","N=5","N=6"];
for n = 1:N
    [z,p,k] = cheb2ap(n,3);       % Lowpass filter prototype
    [num,den] = zp2tf(z,p,k);     % Convert to transfer function form

    w = linspace(0, pi);        
    h = freqs(num,den,w);
    mag = abs(h)/abs(h(1));
    dbmag = 20*log10(mag);
    phase = angle(h);           %输出scale:-pi~pi
    degphase = phase*180/pi;    %转为degree

    subplot(3,1,1), plot(w/pi,mag)
    xlabel('频率');
    ylabel('振幅');
    title('切比雪夫-II 滤波器振幅特性对阶数N的依赖关系')
    grid on;
    hold on;
    
    subplot(3,1,2), plot(w/pi,dbmag)
    xlabel('频率');
    ylabel('振幅 dB');
    title('切比雪夫-II 滤波器振幅特性对阶数N的依赖关系')
    grid on;
    hold on;
    
    subplot(3,1,3), plot(w/pi,degphase)
    xlabel('频率');
    ylabel('相位');
    title('切比雪夫-II 滤波器相位特性对阶数N的依赖关系')
    grid on;
    hold on;
end
legend(str(1),str(2),str(3),str(4),str(5),str(6));

%--------------------------------------------------------------------------
%单独把幅度拿出来显示
%--------------------------------------------------------------------------
figure(4);
N = 6;
str = ["N=1","N=2","N=3","N=4","N=5","N=6"];
for n = 1:N
    [z,p,k] = cheb2ap(n,3);       % Lowpass filter prototype
    [num,den] = zp2tf(z,p,k);     % Convert to transfer function form

    w = linspace(0, pi);        
    h = freqs(num,den,w);
    mag = abs(h)/abs(h(1));
    dbmag = 20*log10(mag);
    phase = angle(h);           %输出scale:-pi~pi
    degphase = phase*180/pi;    %转为degree

    if mod(n,2) == 1 %奇数
    subplot(2,1,1), plot(w/pi,mag)
    xlabel('频率');
    ylabel('振幅');
    title('切比雪夫-II 滤波器振幅特性对阶数N的依赖关系-N为奇数')
    grid on;
    hold on;  
    else %偶数
    subplot(2,1,2), plot(w/pi,mag)
    xlabel('频率');
    ylabel('振幅');
    title('切比雪夫-II 滤波器振幅特性对阶数N的依赖关系-N为偶数')
    grid on;
    hold on;  
    end  
    
end

subplot(2,1,1);%奇数
legend(str(1),str(3),str(5));
subplot(2,1,2);%偶数
legend(str(2),str(4),str(6));