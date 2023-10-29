%Zhou Zhiguo
%2019.4.17
%v1.0
%ZF 
clear; 
close all;
clc;

%定义系统
b=[0 1 0.5];
a=[1 -1 0.5];

r_=0.5*sqrt(2)+0.2:0.1:3;
phi_=0:0.1:2.2*pi;
[r, phi]=meshgrid(r_, phi_);
Z=r.*exp(phi.*1i);
%获取样点绘制数据
z_=ones(1, ceil(length(phi_)/4)).*exp(phi_((1:4:length(phi_))).*1i);
h=(z_+0.5)./(z_.^2-z_+0.5);
H=(Z+0.5)./(Z.^2-Z+0.5);
figure;
%绘制幅度面并调整透明度
[x,y,z]=pol2cart(phi,r,abs(H));
surf(x,y,z);
shading flat;
alpha(0.3); %向坐标区中的对象添加透明度
%绘制取样点
[x, y, z]=pol2cart(phi_((1:4:length(phi_))), ones(1, ceil(length(phi_)/4)),abs(h));
hold on;
stem3(x,y,z,'filled');
hold on;
%获取取样线数据
z_=ones(1, length(phi_)).*exp(phi_.*1i);
h=(z_+0.5)./(z_.^2-z_+0.5);
[x, y, z]=pol2cart(phi_,ones(1,length(phi_)),abs(h));
%绘制取样线
plot3(x,y,z,'LineWidth',2);
%绘制相位面并设置透明度
figure;
[x,y,z]=pol2cart(phi,r,unwrap(angle(H)));
surf(x,y,z);
shading flat;
alpha(0.3);
%获取取样点数据
z_=ones(1, ceil(length(phi_)/4)).*exp(phi_((1:4:length(phi_))).*1i);
h=(z_+0.5)./(z_.^2-z_+0.5);
[x, y, z]=pol2cart(phi_((1:4:length(phi_))), ones(1, ceil(length(phi_)/4)),unwrap(angle(h)));
%绘制取样点
hold on;
stem3(x,y,z,'filled');
hold on;
%获取取样线数据
z_=ones(1, length(phi_)).*exp(phi_.*1i);
h=(z_+0.5)./(z_.^2-z_+0.5);
[x, y, z]=pol2cart(phi_,ones(1,length(phi_)),unwrap(angle(h)));
%绘制取样线
plot3(x,y,z,'LineWidth',2);


%%%曲线绘制单独进行
figure;
z_=ones(1, length(phi_)).*exp(phi_.*1i);
h=(z_+0.5)./(z_.^2-z_+0.5);
plot(phi_,abs(h),'LineWidth',1.5);
axis([0 2*pi 0 4.5]);
figure;
z_=ones(1, length(phi_)).*exp(phi_.*1i);
h=(z_+0.5)./(z_.^2-z_+0.5);
plot(phi_,unwrap(angle(h)),'LineWidth',1.5);
axis([0 2*pi -7 0]);

