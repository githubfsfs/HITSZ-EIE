%实验一（1）
A = rand(10,20)   %创建一个10行20列的随机矩阵
A1 = A(3:8,5:12)  %取矩阵A的第3行第5列到第8行第12列的元素作为子矩阵
sumA1line = sum(A1,1)       %对A1每一列求和
sumA1row = sum(A1,2)       %对A1每一行求和
meanA1line = mean(A1,1)      %求A1每一列的平均值
meanA1row = mean(A1,2)      %求A1每一行的平均值
%方差函数用法var(A,0or1，dim)，0代表无偏方差，除以N-1，1代表有偏方差，除以N。default值为var(A,0,1)，求A每列的方差
varA1line = var(A1,1)      %求A1每一列的方差
varA1row = var(A1,1,2)      %求A1每一行的方差

%实验一（2）
B = rand(3)             %创建一个3行3列的随机矩阵
C = rand(3)             %创建一个3行3列的随机矩阵
K = rand(1)
product = K*B           %K与B的数乘
cube = B^3              %矩阵B的立方
cubeproduct = B.^3      %矩阵B每个元素的立方
D = B./C                %B点除C
E = B+i*C               %B+1jC
transpE = E'                  %B+1jC的转置

%实验一（3）
x=0:0.01:4*pi;
y=sin(x);
plot(x,y)  %（3）名字、横纵坐标有图例，绘图有网格。plot(x, y, ‘r--’, ’linewidth’,2)
title('正弦波图像')
xlabel('x')
axis([0 4*pi -1.5 1.5])
ylabel('y')
grid on
legend('sin(x)')

%实验一（5）
clear all
clc
A=10*rand(10,20)                   %创建随机矩阵A
A2=A(4:8,4:8)
A3=A(5:9,5:9)
corcoeA = zeros(1,5);              %求出A3每列均值
for i=1:5
A3i = A3(:,i);
A2i = A2(:,i);
index=find(A3i>0.5);
A33 = A3i(index);   %每列中大于0.5的值
A22 = A2i(index);   %取出A2中对应元素（保持运算元素一一对应）

sqrtsumA22 = sqrt(sum((A22-mean(A22)).^2));          %计算标准差
sqrtsumA33 = sqrt(sum((A33-mean(A33)).^2));  
covi = sum((A33 - mean(A33)) .* (A22-mean(A22)));    %计算协方差（N-1在下式中消掉了，故没有列出来）      
corcoeA(i) = covi/(sqrtsumA22*sqrtsumA33);           %相关系数
end
x=reshape(corcoeA,1,[]);
y=['A2与A3每列对应相关系数为:',num2str(x)];
% dispA=['A2与A3每列对应相关系数为:',X]
disp(y);
