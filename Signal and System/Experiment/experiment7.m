% �̾��� 180210316
%% 1
close all
syms n z
a = 0.5;
x1 = sin(a*n)
X1 = ztrans(x1);
figure
subplot(1,2,1)
fplot(x1,[0 20]);
title('sin(an)u(n)ʱ��ͼ��')
subplot(1,2,2)
fplot(X1,[-10 10],'-.*g');

X1_theory = z*sin(a)/(z^2-2*z*cos(a)+1)     %�����Ƶ�ֵ
hold on
fplot(X1_theory,[-20 20],'--or');
legend('ʹ��ztrans�������','���ۼ�����')
title('sin(an)u(n)��z��ͼ��')

x2 = (a^n)*find(n>0)
% Ҳ��ֱ��д��x2 = (a^n)
X2 = ztrans(x2)
figure
subplot(1,2,1)
fplot(x2,[-10 10]);
title('a^{n}u(n)ʱ��ͼ��')
subplot(1,2,2)
fplot(X2,[-10 10],'-.*g');
hold on
X2_theory = z/(z-a);                %����ֵ
fplot(X2_theory,[-10 10],'--or')
legend('ʹ��ztrans�������','���ۼ�����')
title('a^{n}u(n)��z��ͼ��')




%% 2
% close all
a = [1 -1 -2];
b = [1 1.5 -1];
subplot(3,1,1)
zplane(a,b);                %�㼫��ֲ�ͼ
title('pole and zero')
h = impz(a,b);              %��λ��ֵ��Ӧ
subplot(3,1,2)
stem(h);
title('impulse respone');
[H,w] = freqz(a,b);         %Ƶ����������
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
h = impz(a,b);          %�㼫��ֲ�ͼ
subplot(3,1,2)
stem(h);                %��λ��ֵ��Ӧ
title('impulse respone');
[H,w] = freqz(a,b);     %Ƶ����������
subplot(3,1,3)
plot(w/pi,abs(H));
xlabel('frequency\omega');
title('magnitude respone')
