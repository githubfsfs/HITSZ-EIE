%% ʵ��һ
close all
R = 2;
L = 0.4e-6;
C = 0.05e-6;
a = [C*L*R 0 0];%ϵͳ��������
b = [C*L*R L R];%ϵͳ������ĸ
w = logspace(0,10,1e6);%���ض���������
h = freqs(a,b,w);%��ϵͳ��������Ϊa,ϵͳ������ĸΪb��Ƶ����Ӧ
mag = abs(h);
phase = angle(h);
phasedeg = phase*180/pi;%angle()�����õ��ĽǶ��ǻ����Ƶģ���Ҫת��Ϊ�Ƕ�ֵ
%���Ʒ�����Ӧ
subplot(2,1,1)
semilogx(w,mag)%x�����������
grid on
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
title('������Ӧ');
hold on

%���3dB��
mag_max = max(mag);
for k = 1:length(w)
    delta = abs(mag(k)- mag_max/sqrt(2));
  if delta < 1e-5
      mag_3dB = mag(k);
      plot(w(k),mag_3dB,'r*');
  end
end
%���Ʒ�����Ӧ
subplot(2,1,2)
semilogx(w,phasedeg)
grid on
xlabel('Frequency (rad/s)')
ylabel('Phase (degrees)')
title('��λ��Ӧ');

%% ʵ���
close all
%ʱ����ͼ
syms x tao 
w = linspace(-30,30,100);
tao = 1;
y = heaviside(x + tao/2)-heaviside(x - tao/2);
fplot(y, [-5, 5]);
title('���������ʱ����ͼ');
grid on
%Ƶ�ʲ���ͼ
Sa = sin(w*tao/2)./(w*tao/2);
Y = tao*Sa;
mag = abs(Y);
phase = angle(Y);
phasedeg = phase*180/pi;%angle()�����õ��ĽǶ��ǻ����Ƶģ���Ҫת��Ϊ�Ƕ�ֵ���Ʒ�����Ӧ
plot(w,Y);
title('���������Ƶ����Ӧ');
grid on
figure
subplot(2,1,1)
plot(w,mag)
grid on
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
title('������Ӧ');
hold on

subplot(2,1,2)
plot(w,phasedeg)
grid on
xlabel('Frequency (rad/s)')
ylabel('Phase (degrees)')
title('��λ��Ӧ');

