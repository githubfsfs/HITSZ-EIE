%180210316 程君兰
%实验一 利用conv和filter函数分别完成卷积
t=0:9;
h=0.5*t;
x=ones(1,6);
y1=conv(h,x)

 %因为filter实质实现差分方程，输出序列与输入序列等长；必须补零才能实现卷积。
 %根据输入序列长度不同，补零个数不同
y2=filter(h,[0 1],[x,zeros(1,9)])     
y3=filter(x,1,[h,zeros(1,5)])
n=(1:15)
y=[y1;y2;y3]';             %stem(x,y）要求x的行数与y的行数匹配，必须对y转置才能实现
subplot(2,2,1)              %多图窗画图，建立2×2个子图，在第一个子图中画图
stem(n,y);legend('total')
subplot(2,2,2)
stem(n,y1);legend('conv(h,x)')
subplot(2,2,3)
stem(n,y2);legend('filter(h,1,[x,zeros(1,9)])')
subplot(2,2,4)
stem(n,y3);legend('filter(x,1,[h,zeros(1,5)])')

%实验二 利用rand函数产生随机噪声，并利用卷积实现平滑滤波（降噪）
n = 0:60;
rng default  %initialize random number generator
s = 5*n.*0.85.^(n);
N = rand(size(n))   %产生随机噪声信号
x = s+N;
plot (n,s);hold on
plot (n,N);
plot (n,x);
legend('有用信号s(n)','噪声信号N(n)','受干扰信号x(n)')
%降噪
display('Please input the value of M');
% 在命令窗口显示提示信息
M = input('M=');   %输入计算均值的数目
ws = 2*M+1;     %定义windowsize为求平均所取序列长度
b = 1/ws*ones(1,ws);    %转移函数分子
% a = [zeros(1,M),1,zeros(1,M)];                  %转移函数分母
% filter(b,a,x)
% plot(x)

y1 = M;
b = 1;
a = 1/ws*ones(1,M+1);
y1 = filter(a,b,x);             %具体y1,y2,y3的表达式见算法分析
y3 = filter(a,b,fliplr(x));     
y2 = fliplr(y3);                %翻转y3信号，得到y2信号
y = y1+y2-1/ws*x;
plot (n,x);
hold on
plot(n,y)
legend('有用信号s(n)','滤波信号')