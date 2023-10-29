%2019.4.15
%Zhou Zhiguo
%DFT sin + cos 题型
%不补零。采样点数16，64，128,512，求DFT

clear; 
close all;

N1=16;
n=0:15;
x=sin(2*pi*n/N1)+cos(4*pi*n/N1);

N2=64;
n2=0:63;
x2=sin(2*pi*n2/N2)+cos(4*pi*n2/N2);

N3=128;
n3=0:127;
x3=sin(2*pi*n3/N3)+cos(4*pi*n3/N3);

N4=512;
n4=0:511;
x4=sin(2*pi*n4/N4)+cos(4*pi*n4/N4);

L1=0:15;
dft_16=fft(x,16);
L2=0:63;
dft_64=fft(x2,64);
L3=0:127;
dft_128=fft(x3,128);
L4=0:511;
dft_512=fft(x4,512);

nx=0:15;
K=512;
dw=2*pi/K;
k=0:511;
X=x*exp(1i*dw*nx'*k);
subplot(4,1,1);
grid on
plot(k*dw/(2*pi),abs(X));

subplot(4,1,2);
stem(L1/N1,abs(dft_16));

subplot(4,1,3);
grid on
stem(L2/64,abs(dft_64));

subplot(4,1,4);
grid on
%stem(L3/128,abs(dft_128));
dft_256 = fft(x,256);
plot(angle(dft_256));
