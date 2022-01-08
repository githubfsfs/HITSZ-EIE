%180210316 �̾���
%ʵ��һ ����conv��filter�����ֱ���ɾ��
t=0:9;
h=0.5*t;
x=ones(1,6);
y1=conv(h,x)

 %��Ϊfilterʵ��ʵ�ֲ�ַ��̣�����������������еȳ������벹�����ʵ�־����
 %�����������г��Ȳ�ͬ�����������ͬ
y2=filter(h,[0 1],[x,zeros(1,9)])     
y3=filter(x,1,[h,zeros(1,5)])
n=(1:15)
y=[y1;y2;y3]';             %stem(x,y��Ҫ��x��������y������ƥ�䣬�����yת�ò���ʵ��
subplot(2,2,1)              %��ͼ����ͼ������2��2����ͼ���ڵ�һ����ͼ�л�ͼ
stem(n,y);legend('total')
subplot(2,2,2)
stem(n,y1);legend('conv(h,x)')
subplot(2,2,3)
stem(n,y2);legend('filter(h,1,[x,zeros(1,9)])')
subplot(2,2,4)
stem(n,y3);legend('filter(x,1,[h,zeros(1,5)])')

%ʵ��� ����rand����������������������þ��ʵ��ƽ���˲������룩
n = 0:60;
rng default  %initialize random number generator
s = 5*n.*0.85.^(n);
N = rand(size(n))   %������������ź�
x = s+N;
plot (n,s);hold on
plot (n,N);
plot (n,x);
legend('�����ź�s(n)','�����ź�N(n)','�ܸ����ź�x(n)')
%����
display('Please input the value of M');
% ���������ʾ��ʾ��Ϣ
M = input('M=');   %��������ֵ����Ŀ
ws = 2*M+1;     %����windowsizeΪ��ƽ����ȡ���г���
b = 1/ws*ones(1,ws);    %ת�ƺ�������
% a = [zeros(1,M),1,zeros(1,M)];                  %ת�ƺ�����ĸ
% filter(b,a,x)
% plot(x)

y1 = M;
b = 1;
a = 1/ws*ones(1,M+1);
y1 = filter(a,b,x);             %����y1,y2,y3�ı��ʽ���㷨����
y3 = filter(a,b,fliplr(x));     
y2 = fliplr(y3);                %��תy3�źţ��õ�y2�ź�
y = y1+y2-1/ws*x;
plot (n,x);
hold on
plot(n,y)
legend('�����ź�s(n)','�˲��ź�')