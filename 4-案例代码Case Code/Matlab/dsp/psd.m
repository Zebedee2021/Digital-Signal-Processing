clear; 
close all;

Fs=2; %采样频率 
%n=0:1/Fs:1; 

N=16;
n=0:15;
xn=sin(2*pi*n/N)+cos(4*pi*n/N);

%产生含有噪声的序列 
%xn=sin(2*pi*40*n)+cos(4*pi*40*n);%+randn(size(n)); 
%xn=sin(2*pi*n/N)+cos(4*pi*n/N);

window=boxcar(length(xn)); %矩形窗 
nfft=1024; 
[Pxx,f]=periodogram(xn,window,nfft,Fs); %直接法 
plot(f,10*log10(Pxx)); 
