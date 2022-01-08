%% 实验一
close all
R = 2;
L = 0.4e-6;
C = 0.05e-6;
a = [C*L*R 0 0];%系统函数分子
b = [C*L*R L R];%系统函数分母
w = logspace(0,10,1e6);%返回对数化数组
h = freqs(a,b,w);%求系统函数分子为a,系统函数分母为b的频率响应
mag = abs(h);
phase = angle(h);
phasedeg = phase*180/pi;%angle()函数得到的角度是弧度制的，需要转换为角度值
%绘制幅度响应
subplot(2,1,1)
semilogx(w,mag)%x坐标轴对数化
grid on
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
title('幅度响应');
hold on

%标出3dB点
mag_max = max(mag);
for k = 1:length(w)
    delta = abs(mag(k)- mag_max/sqrt(2));
  if delta < 1e-5
      mag_3dB = mag(k);
      plot(w(k),mag_3dB,'r*');
  end
end
%绘制幅度响应
subplot(2,1,2)
semilogx(w,phasedeg)
grid on
xlabel('Frequency (rad/s)')
ylabel('Phase (degrees)')
title('相位响应');

%% 实验二
close all
%时域波形图
syms x tao 
w = linspace(-30,30,100);
tao = 1;
y = heaviside(x + tao/2)-heaviside(x - tao/2);
fplot(y, [-5, 5]);
title('矩形脉冲的时域波形图');
grid on
%频率波形图
Sa = sin(w*tao/2)./(w*tao/2);
Y = tao*Sa;
mag = abs(Y);
phase = angle(Y);
phasedeg = phase*180/pi;%angle()函数得到的角度是弧度制的，需要转换为角度值绘制幅度响应
plot(w,Y);
title('矩形脉冲的频率响应');
grid on
figure
subplot(2,1,1)
plot(w,mag)
grid on
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
title('幅度响应');
hold on

subplot(2,1,2)
plot(w,phasedeg)
grid on
xlabel('Frequency (rad/s)')
ylabel('Phase (degrees)')
title('相位响应');

