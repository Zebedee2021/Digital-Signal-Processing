% Zhou Zhiguo
% 2019.5.2
% Ch5 数字滤波器设计

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% Chebyshev Type I 多项式
% https://ww2.mathworks.cn/help/symbolic/chebyshevt.html
%--------------------------------------------------------------------------
figure;
syms x y
fplot(chebyshevT(0:4,x))
%axis([-5 5 -6 6])
axis([0 3 -2 4])   %注意：课本 x>0
grid on

ylabel('T_n(x)')
legend('T_0(x)','T_1(x)','T_2(x)','T_3(x)','T_4(x)','Location','Best')
title('Chebyshev polynomials of the first kind')

%--------------------------------------------------------------------------
% Chebyshev Type I 多项式 平方
%--------------------------------------------------------------------------
figure;
syms x y
fplot(power(chebyshevT(0:4,x),2))
%axis([-5 5 -6 6])
axis([0 3 0 4]) 
grid on

ylabel('T^2_n(x)')
legend('T^2_0(x)','T^2_1(x)','T^2_2(x)','T^2_3(x)','T^2_4(x)','Location','Best')
title('Chebyshev polynomials^2 of the first kind')

%--------------------------------------------------------------------------
% Chebyshev Type II 多项式
% https://ww2.mathworks.cn/help/symbolic/chebyshevu.html
%--------------------------------------------------------------------------
figure;
syms x y
fplot(chebyshevU(0:4, x))
%axis([-1.5 1.5 -2 2])
axis([0 3 -2 4])
grid on

ylabel('U_n(x)')
legend('U_0(x)', 'U_1(x)', 'U_2(x)', 'U_3(x)', 'U_4(x)', 'Location', 'Best')
title('Chebyshev polynomials of the second kind')

%--------------------------------------------------------------------------
% Chebyshev Type II 多项式 平方
%--------------------------------------------------------------------------
figure;
syms x y
fplot(power(chebyshevU(0:4,x),2))
%axis([-5 5 -6 6])
axis([0 3 0 4]) 
grid on

ylabel('U^2_n(x)')
legend('U^2_0(x)', 'U^2_1(x)', 'U^2_2(x)', 'U^2_3(x)', 'U^2_4(x)', 'Location', 'Best')
title('Chebyshev polynomials^2 of the second kind')
