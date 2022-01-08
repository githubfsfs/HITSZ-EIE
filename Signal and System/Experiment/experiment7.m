%% 1
close all
syms n z
a = 0.5;
x1 = sin(a*n)
X1 = ztrans(x1);
figure
subplot(1,2,1)
fplot(x1,[0 20]);
title('sin(an)u(n)时域图像')
subplot(1,2,2)
fplot(X1,[-10 10],'-.*g');

X1_theory = z*sin(a)/(z^2-2*z*cos(a)+1)     %理论推导值
hold on
fplot(X1_theory,[-20 20],'--or');
legend('使用ztrans函数结果','理论计算结果')
title('sin(an)u(n)的z域图像')

x2 = (a^n)*find(n>0)
% 也可直接写成x2 = (a^n)
X2 = ztrans(x2)
figure
subplot(1,2,1)
fplot(x2,[-10 10]);
title('a^{n}u(n)时域图像')
subplot(1,2,2)
fplot(X2,[-10 10],'-.*g');
hold on
X2_theory = z/(z-a);                %理论值
fplot(X2_theory,[-10 10],'--or')
legend('使用ztrans函数结果','理论计算结果')
title('a^{n}u(n)的z域图像')




%% 2
% close all
a = [1 -1 -2];
b = [1 1.5 -1];
subplot(3,1,1)
zplane(a,b);                %零极点分布图
title('pole and zero')
h = impz(a,b);              %单位样值响应
subplot(3,1,2)
stem(h);
title('impulse respone');
[H,w] = freqz(a,b);         %频响特性曲线
subplot(3,1,3)
plot(w/pi,abs(H));
xlabel('frequency\omega');
title('magnitude respone')

%% 3
close all
a = [0 1];
b = [1 -1.1 0.7];
subplot(3,1,1)
zplane(a,b);
title('pole and zero')
h = impz(a,b);          %零极点分布图
subplot(3,1,2)
stem(h);                %单位样值响应
title('impulse respone');
[H,w] = freqz(a,b);     %频响特性曲线
subplot(3,1,3)
plot(w/pi,abs(H));
xlabel('frequency\omega');
title('magnitude respone')
