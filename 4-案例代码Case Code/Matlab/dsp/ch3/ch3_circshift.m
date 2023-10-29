%Zhou Zhiguo
%2019.4.21
%v1.0
%‘≤÷‹“∆Œª
clear; 
close all;
clc;

% øŒº˛
u = [0 1 2 1 0];
v = [0 1 0 1 0];
Lconv = conv(u,v);

u1 = circshift(u,2);  %—≠ª∑”““∆2£∫u1=u((n-2));
v1 = circshift(u,-2); %—≠ª∑◊Û“∆2£∫v1=u((n+2));

u2 = circshift(flip(u),1);  %–Ú¡–∑¥◊™°¢—≠ª∑”““∆1£∫u2=u(-n);
x = circshift(u2,2);        %—≠ª∑”““∆2£∫x=u((-n+2))=u(-(n-2));

%’π æ
subplot(5,1,1);
stem(u);
xlabel('–Ú∫≈');
ylabel('u(n)');
grid on;

subplot(5,1,2);
stem(v);
xlabel('–Ú∫≈');
ylabel('v(n)');
grid on;

subplot(5,1,3);
stem(u1);
xlabel('–Ú∫≈');
ylabel('u1');
grid on;

subplot(5,1,4);
stem(u2);
xlabel('–Ú∫≈');
ylabel('u2');
grid on;

subplot(5,1,5);
stem(x);
xlabel('–Ú∫≈');
ylabel('x');
grid on;