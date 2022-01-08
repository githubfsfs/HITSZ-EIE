% 180210316 程君兰 信号与系统实验六
%% （1）
%利用部分分式展开法求下式函数的拉普拉斯逆变换
%并和 ilaplace函数求得的结果对比。
b = [1 0 3];        %分子系数
a = [1 4 9 10];     %分母系数
% [r p k] = residue(b,a)  %分子系数在前，分母系数在后
% sys = tf(b,a)
% f = ilaplace(sys)

syms s
F = (s^2+3)/((s^2+2*s+5)*(s+2));
f = ilaplace(F);

%% (2)
%%探究极点对冲激响应的影响
b1 = [1];
a1 = [1 0 4];
H1 = tf(b1,a1);
subplot(3,2,1);
pzmap(H1)
axis([-1 1 -4 4])
title('H1(t)');
subplot(3,2,2);
impulse(b1,a1)
% axis([0 15 -1 1])
set(gca,'xtick',4:4:20);
figure
impulse(b1,a1)
axis([0 28 -1 1])
set(gca,'xtick',4:4:20);

b2 = [1];
a2 = [1 2 17];
H2 = tf(b2,a2);
subplot(3,2,3)
pzmap(H2)
axis([-1 1 -4 4]);
title('H2(t)');
subplot(3,2,4);
impulse(b2,a2)
axis([0 15 -0.2 0.2]);

b3 = [1];
a3 = [1 -2 17];
H3 = tf(b3,a3);
subplot(3,2,5);
pzmap(H3)
axis([-1 1 -4 4])
title('H3(t)');
subplot(3,2,6);
impulse(b3,a3)
axis([0 15 -10^5 10^5])

%% (3)
%探究零点对冲激响应的影响
close all
grid
b1 = [1];
a1 = [1 2 17];
H1 = tf(b1,a1);
subplot(3,2,1);
pzmap(H1)
axis([-8 8 -4 4]);
title('H1(t)');
subplot(3,2,2);
impulse(b1,a1)
axis([0 10 -2 2])

b2 = [1 8];
a2 = [1 2 17];
H2 = tf(b2,a2);
subplot(3,2,3)
pzmap(H2)
axis([-8 8 -4 4]);
title('H2(t)');
subplot(3,2,4);
impulse(b2,a2)
axis([0 10 -2 2])

b3 = [1 -8];
a3 = [1 2 17];
H3 = tf(b3,a3);
subplot(3,2,5);
pzmap(H3)
axis([-8 8 -4 4]);
title('H3(t)');
subplot(3,2,6);
impulse(b3,a3)
axis([0 10 -2 2])