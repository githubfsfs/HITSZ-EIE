%ʵ��һ��1��
A = rand(10,20)   %����һ��10��20�е��������
A1 = A(3:8,5:12)  %ȡ����A�ĵ�3�е�5�е���8�е�12�е�Ԫ����Ϊ�Ӿ���
sumA1line = sum(A1,1)       %��A1ÿһ�����
sumA1row = sum(A1,2)       %��A1ÿһ�����
meanA1line = mean(A1,1)      %��A1ÿһ�е�ƽ��ֵ
meanA1row = mean(A1,2)      %��A1ÿһ�е�ƽ��ֵ
%������÷�var(A,0or1��dim)��0������ƫ�������N-1��1������ƫ�������N��defaultֵΪvar(A,0,1)����Aÿ�еķ���
varA1line = var(A1,1)      %��A1ÿһ�еķ���
varA1row = var(A1,1,2)      %��A1ÿһ�еķ���

%ʵ��һ��2��
B = rand(3)             %����һ��3��3�е��������
C = rand(3)             %����һ��3��3�е��������
K = rand(1)
product = K*B           %K��B������
cube = B^3              %����B������
cubeproduct = B.^3      %����Bÿ��Ԫ�ص�����
D = B./C                %B���C
E = B+i*C               %B+1jC
transpE = E'                  %B+1jC��ת��

%ʵ��һ��3��
x=0:0.01:4*pi;
y=sin(x);
plot(x,y)  %��3�����֡�����������ͼ������ͼ������plot(x, y, ��r--��, ��linewidth��,2)
title('���Ҳ�ͼ��')
xlabel('x')
axis([0 4*pi -1.5 1.5])
ylabel('y')
grid on
legend('sin(x)')

%ʵ��һ��5��
clear all
clc
A=10*rand(10,20)                   %�����������A
A2=A(4:8,4:8)
A3=A(5:9,5:9)
corcoeA = zeros(1,5);              %���A3ÿ�о�ֵ
for i=1:5
A3i = A3(:,i);
A2i = A2(:,i);
index=find(A3i>0.5);
A33 = A3i(index);   %ÿ���д���0.5��ֵ
A22 = A2i(index);   %ȡ��A2�ж�ӦԪ�أ���������Ԫ��һһ��Ӧ��

sqrtsumA22 = sqrt(sum((A22-mean(A22)).^2));          %�����׼��
sqrtsumA33 = sqrt(sum((A33-mean(A33)).^2));  
covi = sum((A33 - mean(A33)) .* (A22-mean(A22)));    %����Э���N-1����ʽ�������ˣ���û���г�����      
corcoeA(i) = covi/(sqrtsumA22*sqrtsumA33);           %���ϵ��
end
x=reshape(corcoeA,1,[]);
y=['A2��A3ÿ�ж�Ӧ���ϵ��Ϊ:',num2str(x)];
% dispA=['A2��A3ÿ�ж�Ӧ���ϵ��Ϊ:',X]
disp(y);
