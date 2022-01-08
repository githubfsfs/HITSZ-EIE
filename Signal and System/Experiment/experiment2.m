% 观察周期方波信号的分解与合成
% m: 傅立叶级数展开的项数
display('Please input the value of m(傅立叶级数展开的项数)');
% 在命令窗口显示提示信息
m = input('m=');                            % 输入傅立叶级数展开的项数
t = (-4*pi+0.01):0.01:2*pi;                 % 时域波形的时间范围(-4pi 2pi)
%左边小于-2pi是因为后面要平移
f = sawtooth(t);                            %利用sawtooth创建锯齿波
y = zeros(m+1,max(size(t)))                 %取t中维度长度最大量，正常情况下用size(t)即可
y(m+1,:) = f'
figure(1)
plot(t/pi+1,y(m+1,:))                      	% 绘制锯齿波信号
grid;                                            	% 在图形中加入栅格
axis([-2 2 -1.5 1.5])                         	% 指定图形显示的横纵座标范围

title('周期锯齿波')
xlabel('单位：  pi','Fontsize',8)
x = zeros(size(t))  %1256
kk = '1'                                        %kk是字符串，不能进行代数运算
for k =1:m                                      % 循环显示谐波叠加波形
    pause;                                      %回车键继续
    x = x + (-1)^(k+1)*sin(k*t)/k               % 计算各次谐波叠加和
    y(k,:) = x/pi*2
    plot(t/pi+1,y(m+1,:))
    hold on
    plot(t/pi,y(k,:))                          % 绘制谐波叠加信号
    hold off;                                   %避免与后面的图案画在一起
    grid;
    axis([-2 2 -1.5 1.5]);
    title(strcat('第', kk, '次谐波叠加'))
    xlabel('单位：  pi','Fontsize',8)
    kk = strcat(kk,'、',num2str(k+1))           
end
pause
hold on
plot(t/pi,y(1:m,:))
plot(t/pi+1,y(m+1,:))
grid on;
axis([-2 2 -1.5 1.5])  
title('各次谐波叠加波形');
xlabel('单位：  pi','Fontsize',8);
