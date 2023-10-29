% Zhou Zhiguo
% 2019.4.26
% Ch5 数字滤波器设计
% 说明：Matlab 帮助文档 4种线性相位

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/dsp/ref/firtype.html?s_tid=doc_ta

% N指：序列长度
% case1：h(n)中心偶对称，N为奇数
% case2：h(n)中心偶对称，N为偶数
% case3：h(n)中心奇对称，N为奇数
% case4：h(n)中心奇对称，N为偶数

% N指：滤波器阶数，比课本序列长度小1
% Filter type, returned as either 1, 2, 3, or 4. Filter types are defined as follows:
% Type 1 — Even-order symmetric coefficients     h(n)偶对称，F偶数阶，N为奇数
% Type 2 — Odd-order symmetric coefficients      h(n)偶对称，F奇数阶，N为偶数
% Type 3 — Even-order antisymmetric coefficients h(n)奇对称，F偶数阶，N为奇数
% Type 4 — Odd-order antisymmetric coefficients  h(n)奇对称，F奇数阶，N为偶数
%--------------------------------------------------------------------------
figure;
%Type 1 — Even-order symmetric coefficients <=> case1：h(n)偶对称，F偶数阶，N为奇数   
subplot(2,1,1)
h1 = fir1(8,0.5);
impz(h1), title(['Type ' int2str(firtype(h1))])

% Type 2 — Odd-order symmetric coefficients <=> case2：h(n)偶对称，F奇数阶，N为偶数
subplot(2,1,2)
h2 = fir1(9,0.5);
impz(h2), title(['Type ' int2str(firtype(h2))])

% Type 3 — Even-order antisymmetric coefficients <=> case3：h(n)奇对称，F偶数阶，N为奇数
figure;
subplot(2,1,1)
h3 = firpm(8,[0.2 0.8],[1 1],'hilbert');
impz(h3), title(['Type ' int2str(firtype(h3))])

% Type 4 — Odd-order antisymmetric coefficients  <=> case4：h(n)奇对称，F奇数阶，N为偶数
subplot(2,1,2)
h4 = firpm(9,[0.2 0.8],[1 1],'hilbert');
impz(h4), title(['Type ' int2str(firtype(h4))])

fvtool(h1);
fvtool(h2);
fvtool(h3);
fvtool(h4);
%--------------------------------------------------------------------------
% Use designfilt to design the filters from the previous example. Display their types.
d1 = designfilt('lowpassfir','DesignMethod','window', ...
                'FilterOrder',8,'CutoffFrequency',0.5);
disp(['d1 is of type ' int2str(firtype(d1))])
%--------------------------------------------------------------------------

