%�ź���ϵͳʵ����  
%180210316 �̾���

%%
%˫��ָ���ź�Ƶ��ͼ
% f1 = @(t) exp(-abs(t))
syms t
f1 = exp(-abs(t))
F1 = fourier(f1)
subplot(1,2,1)
fplot(f1)     %t�ᶨ����Ϊ[-5,5]Ϊ��ʡ����
axis([-5 5 0 3])
title('two�Csided exponential signal');xlabel('t') ;ylabel('f(t)') %���β���Ƶ��
subplot(1,2,2)
fplot(abs(F1)) 
axis([-10 10 0 3])
title('amplitude spectrum of two�Csided exponential signal');xlabel('\omega');ylabel('|F(\omega)|')   %���β���Ƶ��

%%
%�����������Ƶ����
%��һ����������洢F(w)
t = -3:0.01:3;
w = -30:0.01:30;
tau = 1;
E = 1;
f = tripuls(t,tau,0);       %��tripuls�����������ǲ�
plot(t,f)
F = f*exp(-j*t'*w)*0.01;    %FΪ1��w����������
% F = f*[exp(-j*w'*t)]';    %Ҳ���������������ĵȼ�
subplot(1,2,1)
plot(w, abs(F))     %ʹ��abs������Fȡģ
title('amplitude spectrum of tritangular pulses ');xlabel('\omega');ylabel('|F(\omega)|')   %���β���Ƶ��

%������������κ���������ѭ�����F(w)
f1 = @(t,w)(t>=-0.5 & t<=0.5).*(1-2*abs(t)).*exp(-j*w*t)   %f1(t,w)��wΪ������tΪ�Ա���
N = length(w);
F = zeros(1,N);                              %�����������������������洢
for k=1:N
    F(k) = integral(@(t) f1(t,w(k)),-0.5,0.5);  %f1(t,w(k))��ʾ����w=w(k)ʱ����Ӧ��f1ֵ����[-0.5,0.5]�ϻ���
end
subplot(1,2,2)
plot(w,abs(F));title('amplitude spectrum of tritangular pulses ')
xlabel('\omega');ylabel('F(\omega)');

%%
%����취�����������������
syms t w;
f1 = sqrt(2)*(heaviside(t+0.25)-heaviside(t-0.25));     %���β�
F1 = fourier(f1,t,w);                                           %���β�FT
subplot(2,2,1)
fplot(f1,[-10,10]);      
title('rectangular pulse');xlabel('t')

subplot(2,2,2)
fplot(abs(F1),[-50*pi,50*pi])
title('Magnitude of rectangular pulses FT');xlabel('\omega')  %���β���Ƶ��
axis([-50 50 0 0.8])

F2 = F1*F1                      %���������FT���ڶ�Ӧ���������FT�ĳ˻�
f2= @(t)(t>=-0.5 & t<=0.5),.*(1-2*abs(t))
subplot(2,2,3)
fplot(f2);      
title('triangular pulse');xlabel('t')

subplot(2,2,4)
fplot(abs(F2),[-50*pi,50*pi]);      
title('Magnitude of tritangular pulses FT');xlabel('\omega')
axis([-50 50 0 0.8])

%%
%�������������FT��ֱ�ӻ�����
figure
syms w
F = 8*(sin(0.25*w))^2/w^2
fplot(w,abs(F),[-30*pi,30*pi])
title('Magnitude of tritangular pulses FT');xlabel('\omega');ylabel('|F(j\omega)|')
f = ifourier(F)
fplot(f)

%%
%����Ƶ��������׵Ĺ�ϵ
w = -3*pi:0.001:3*pi;
%����Ƶ��Ϊ2Hz
t = -100:0.5:100;
f31 = sin(0.8*pi*t);
subplot(3,2,1)
stem(t,f31)
axis([0 20 -1 1])
title('sampling freq = 2Hz')
xlabel('t');ylabel('f[t]');

F31 = f31*[exp(-j*w'*t)]';
subplot(3,2,2)
plot(w/pi,abs(F31))         %������������Ϊw/pi���Ա���õع۲�w������׷��ȵĶ�Ӧ��ϵ
axis([-3 3 0 20])
title('amplitude spectrum with sampling freq = 2Hz')
xlabel('\omega in unit pi');ylabel('|F(\omega)|');

%����Ƶ��Ϊ0.8Hz
t = 0.625:1.25:100;
f32 = sin(0.8*pi*t);
subplot(3,2,3)
stem(t,f32);
axis([0 20 -1 1])
title('sampling freq = 0.8Hz')
xlabel('t');ylabel('f[t]');

F32 = f32*[exp(-j*w'*t)]';
subplot(3,2,4)
plot(w/pi,abs(F32));axis([-3 3 0 20]);
title('amplitude spectrum with sampling freq = 0.8Hz')
xlabel('\omega in unit pi');ylabel('|F(\omega)|');

%����Ƶ��Ϊ0.4Hz
t = 0.625:2.5:100;
f33 = sin(0.8*pi*t);
subplot(3,2,5)
stem(t,f33)
axis([0 20 -1 1])
title('sampling freq = 0.4Hz')
xlabel('t');ylabel('f[t]');

F33 = f33*[exp(-1i*w'*t)]';
subplot(3,2,6)
plot(w/pi,abs(F33));axis([-3 3 0 20])
title('amplitude spectrum with sampling freq = 0.4Hz')
xlabel('\omega in unit pi');ylabel('|F(\omega)|');

%%
%����Ƶ����ͬ�������㲻ͬ�Է����׵�Ӱ��
%����Ƶ��Ϊ0.8Hz
t = 0:1.25:20;
f32 = sin(0.8*pi*t);
subplot(2,2,1)
stem(t,f32)
axis([0 20 -1 1])
title('sampling freq = 0.8Hz')
xlabel('t');ylabel('f[t]');

F32 = f32*[exp(-j*w'*t)]'
subplot(2,2,2)
plot(w/pi,abs(F32));axis([-3 3 0 20])
title('amplitude spectrum with sampling freq = 0.8Hz')
xlabel('\omega in unit pi');ylabel('|F(\omega)|');

t = 0.625:1.25:20;
f31 = sin(0.8*pi*t);
subplot(2,2,3)
stem(t/pi,f31)
title('sampling freq = 0.8 Hz')
xlabel('t');ylabel('f[t]');

F31 = f31*[exp(-j*w'*t)]';
subplot(2,2,4)
plot(w/pi,abs(F31))
axis([-3 3 0 20])
title('amplitude spectrum with sampling freq = 0.8 Hz')
xlabel('\omega in unit pi');ylabel('|F(\omega)|');

%%
%����Ƶ����Ƶ�׵Ĺ�ϵ���۲�������(����ʵ�����ݣ�)
%����Ƶ��Ϊ1Hz
t = 0.625:1:20;
f31 = sin(0.8*pi*t);
subplot(4,2,1)
stem(t/pi,f31)
title('sampling freq = 1Hz')
xlabel('t');ylabel('f[t]');

F31 = f31*[exp(-j*w'*t)]';
subplot(4,2,2)
plot(w/pi,abs(F31))
axis([-3 3 0 20])
title('amplitude spectrum with sampling freq = 1Hz')
xlabel('\omega in unit pi');ylabel('|F(\omega)|');

%����Ƶ��Ϊ0.91Hz
t = 0.625:1.1:20;
f31 = sin(0.8*pi*t);
subplot(4,2,3)
stem(t/pi,f31)
title('sampling freq = 0.91 Hz')
xlabel('t');ylabel('f[t]');

F31 = f31*[exp(-j*w'*t)]';
subplot(4,2,4)
plot(w/pi,abs(F31))
axis([-3 3 0 20])
title('amplitude spectrum with sampling freq = 0.91 Hz')
xlabel('\omega in unit pi');ylabel('|F(\omega)|');

%����Ƶ��Ϊ0.83Hz
t = 0.625:1.2:20;
f31 = sin(0.8*pi*t);
subplot(4,2,5)
stem(t/pi,f31)
title('sampling freq = 0.83 Hz')
xlabel('t');ylabel('f[t]');

F31 = f31*[exp(-j*w'*t)]';
subplot(4,2,6)
plot(w/pi,abs(F31))
axis([-3 3 0 20])
title('amplitude spectrum with sampling freq = 0.83 Hz')
xlabel('\omega in unit pi');ylabel('|F(\omega)|');

%����Ƶ��Ϊ0.8Hz
t = 0.625:1.25:20;
f31 = sin(0.8*pi*t);
subplot(4,2,7)
stem(t/pi,f31)
title('sampling freq = 0.8 Hz')
xlabel('t');ylabel('f[t]');

F31 = f31*[exp(-j*w'*t)]';
subplot(4,2,8)
plot(w/pi,abs(F31))
axis([-3 3 0 20])
title('amplitude spectrum with sampling freq = 0.8 Hz')
xlabel('\omega in unit pi');ylabel('|F(\omega)|');


%%
%���β��ķ���������λ��
%�ź����� 10���źſ�� 1��
tau = 1
T = 10
E = 1
w = 2*pi/T

n = 1:20;
a0 = E*tau/T
an = E*tau*w*sinc(n*w*tau/2/pi)/pi;
subplot(3,2,1)
stem([0,n],[a0,abs(an)])                 %�������β��ķ����ף���ɢ��
hold on
plot(n,abs(an),'--')                     %�����߻�������
hold off
title('amplitude spectrum of rectangular wave')
xlabel('\omega');ylabel('|c_n|')
axis([0 20 0 0.4])

subplot(3,2,2)
stem([0,n],[angle([a0,an])])                %�������β�����λ��
title('phase spectrum of rectangular wave')
xlabel('\omega');ylabel('\phi_n')

%�ź����� 10���źſ�� 2��
tau = 2
T = 10
w = 2*pi/T
a0 = E*tau/T
an = E*tau*w*sinc(n*w*tau/2/pi)/pi;
subplot(3,2,3)
stem([0,n],[a0,abs(an)])        %�������β��ķ����ף���ɢ��
hold on
plot(n,abs(an),'--')            %�����߻�������
hold off
title('amplitude spectrum of rectangular wave')
xlabel('\omega');ylabel('|c_n|')
axis([0 20 0 0.4])

subplot(3,2,4)
stem([0,n],[angle([a0,an])])                %�������β�����λ��
title('phase spectrum of rectangular wave')
xlabel('\omega');ylabel('\phi_n')

%�ź����� 5���źſ�� 1��
tau = 1
T = 5
w = 2*pi/T
a0 = E*tau/T
an = E*tau*w*sinc(n*w*tau/2/pi)/pi;
subplot(3,2,5)
stem([0,n],[a0,abs(an)])        %�������β��ķ����ף���ɢ��
hold on
plot(n,abs(an),'--')            %�����߻�������
hold off
title('amplitude spectrum of rectangular wave')
xlabel('\omega');ylabel('|c_n|')
axis([0 20 0 0.4])

subplot(3,2,6)
stem([0,n],[angle([a0,an])])                %�������β�����λ��
title('phase spectrum of rectangular wave')
xlabel('\omega');ylabel('\phi_n')
