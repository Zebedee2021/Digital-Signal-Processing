function X = dtft(x)
% Zhou Zhiguo
% 2019.5.6
% DTFT计算

K=512;
%dw=2*pi/K;
%k=0:511;
%X=x*exp(-1i*dw*n'*k);
X=fft(x,K);
%subplot(3,1,2);
%plot(k*dw,abs(X));
% plot(k*dw,abs(X));
% xlim([0 2*pi]);
% ylim([0 10]);
% xlabel('数字频率 0~2\pi');
% ylabel('幅值');
% title('幅频响应|X(e^j^\omega)|');
%---------------------------------------------------------
% subplot(3,1,3);
% plot(k*dw,angle(X));
% xlim([0 2*pi]);
% ylim([-pi pi]);
% xlabel('数字频率 0~2\pi');
% ylabel('相位');
% title('相频响应 arg{X(e^j^\omega)}')
