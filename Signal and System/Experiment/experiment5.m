%信号与系统实验五  
%180210316 程君兰

%%
%双边指数信号频谱图
% f1 = @(t) exp(-abs(t))
syms t
f1 = exp(-abs(t))
F1 = fourier(f1)
subplot(1,2,1)
fplot(f1)     %t轴定义域为[-5,5]为归省设置
axis([-5 5 0 3])
title('two–sided exponential signal');xlabel('t') ;ylabel('f(t)') %矩形波的频谱
subplot(1,2,2)
fplot(abs(F1)) 
axis([-10 10 0 3])
title('amplitude spectrum of two–sided exponential signal');xlabel('\omega');ylabel('|F(\omega)|')   %矩形波的频谱

%%
%三角脉冲的相频特性
%法一：利用数组存储F(w)
t = -3:0.01:3;
w = -30:0.01:30;
tau = 1;
E = 1;
f = tripuls(t,tau,0);       %用tripuls函数画出三角波
plot(t,f)
F = f*exp(-j*t'*w)*0.01;    %F为1×w长的行向量
% F = f*[exp(-j*w'*t)]';    %也可用这个，跟上面的等价
subplot(1,2,1)
plot(w, abs(F))     %使用abs函数对F取模
title('amplitude spectrum of tritangular pulses ');xlabel('\omega');ylabel('|F(\omega)|')   %矩形波的频谱

%法二：设出含参函数，利用循环算出F(w)
f1 = @(t,w)(t>=-0.5 & t<=0.5).*(1-2*abs(t)).*exp(-j*w*t)   %f1(t,w)中w为参数，t为自变量
N = length(w);
F = zeros(1,N);                              %事先设好零向量，方便后续存储
for k=1:N
    F(k) = integral(@(t) f1(t,w(k)),-0.5,0.5);  %f1(t,w(k))表示参数w=w(k)时，对应的f1值。在[-0.5,0.5]上积分
end
subplot(1,2,2)
plot(w,abs(F));title('amplitude spectrum of tritangular pulses ')
xlabel('\omega');ylabel('F(\omega)');

%%
%卷积办法画出三角脉冲幅度谱
syms t w;
f1 = sqrt(2)*(heaviside(t+0.25)-heaviside(t-0.25));     %矩形波
F1 = fourier(f1,t,w);                                           %矩形波FT
subplot(2,2,1)
fplot(f1,[-10,10]);      
title('rectangular pulse');xlabel('t')

subplot(2,2,2)
fplot(abs(F1),[-50*pi,50*pi])
title('Magnitude of rectangular pulses FT');xlabel('\omega')  %矩形波的频谱
axis([-50 50 0 0.8])

F2 = F1*F1                      %三角脉冲的FT等于对应矩形脉冲的FT的乘积
f2= @(t)(t>=-0.5 & t<=0.5),.*(1-2*abs(t))
subplot(2,2,3)
fplot(f2);      
title('triangular pulse');xlabel('t')

subplot(2,2,4)
fplot(abs(F2),[-50*pi,50*pi]);      
title('Magnitude of tritangular pulses FT');xlabel('\omega')
axis([-50 50 0 0.8])

%%
%计算三角脉冲的FT，直接画出来
figure
syms w
F = 8*(sin(0.25*w))^2/w^2
fplot(w,abs(F),[-30*pi,30*pi])
title('Magnitude of tritangular pulses FT');xlabel('\omega');ylabel('|F(j\omega)|')
f = ifourier(F)
fplot(f)

%%
%抽样频率与幅度谱的关系
w = -3*pi:0.001:3*pi;
%采样频率为2Hz
t = -100:0.5:100;
f31 = sin(0.8*pi*t);
subplot(3,2,1)
stem(t,f31)
axis([0 20 -1 1])
title('sampling freq = 2Hz')
xlabel('t');ylabel('f[t]');

F31 = f31*[exp(-j*w'*t)]';
subplot(3,2,2)
plot(w/pi,abs(F31))         %这里令坐标轴为w/pi，以便更好地观察w与幅度谱幅度的对应关系
axis([-3 3 0 20])
title('amplitude spectrum with sampling freq = 2Hz')
xlabel('\omega in unit pi');ylabel('|F(\omega)|');

%抽样频率为0.8Hz
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

%抽样频率为0.4Hz
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
%抽样频率相同，抽样点不同对幅度谱的影响
%抽样频率为0.8Hz
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
%抽样频率与频谱的关系，观察混叠现象(▲非实验内容！)
%抽样频率为1Hz
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

%抽样频率为0.91Hz
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

%抽样频率为0.83Hz
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

%抽样频率为0.8Hz
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
%矩形波的幅度谱与相位谱
%信号周期 10，信号宽度 1。
tau = 1
T = 10
E = 1
w = 2*pi/T

n = 1:20;
a0 = E*tau/T
an = E*tau*w*sinc(n*w*tau/2/pi)/pi;
subplot(3,2,1)
stem([0,n],[a0,abs(an)])                 %画出矩形波的幅度谱（离散）
hold on
plot(n,abs(an),'--')                     %用虚线画出包络
hold off
title('amplitude spectrum of rectangular wave')
xlabel('\omega');ylabel('|c_n|')
axis([0 20 0 0.4])

subplot(3,2,2)
stem([0,n],[angle([a0,an])])                %画出矩形波的相位谱
title('phase spectrum of rectangular wave')
xlabel('\omega');ylabel('\phi_n')

%信号周期 10，信号宽度 2。
tau = 2
T = 10
w = 2*pi/T
a0 = E*tau/T
an = E*tau*w*sinc(n*w*tau/2/pi)/pi;
subplot(3,2,3)
stem([0,n],[a0,abs(an)])        %画出矩形波的幅度谱（离散）
hold on
plot(n,abs(an),'--')            %用虚线画出包络
hold off
title('amplitude spectrum of rectangular wave')
xlabel('\omega');ylabel('|c_n|')
axis([0 20 0 0.4])

subplot(3,2,4)
stem([0,n],[angle([a0,an])])                %画出矩形波的相位谱
title('phase spectrum of rectangular wave')
xlabel('\omega');ylabel('\phi_n')

%信号周期 5，信号宽度 1。
tau = 1
T = 5
w = 2*pi/T
a0 = E*tau/T
an = E*tau*w*sinc(n*w*tau/2/pi)/pi;
subplot(3,2,5)
stem([0,n],[a0,abs(an)])        %画出矩形波的幅度谱（离散）
hold on
plot(n,abs(an),'--')            %用虚线画出包络
hold off
title('amplitude spectrum of rectangular wave')
xlabel('\omega');ylabel('|c_n|')
axis([0 20 0 0.4])

subplot(3,2,6)
stem([0,n],[angle([a0,an])])                %画出矩形波的相位谱
title('phase spectrum of rectangular wave')
xlabel('\omega');ylabel('\phi_n')
