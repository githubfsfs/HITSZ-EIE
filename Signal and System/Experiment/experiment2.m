%���ߣ���������Ϣ����ѧԺ �̾��� 180210316
% �۲����ڷ����źŵķֽ���ϳ�
% m: ����Ҷ����չ��������
display('Please input the value of m(����Ҷ����չ��������)');
% ���������ʾ��ʾ��Ϣ
m = input('m=');                            % ���븵��Ҷ����չ��������
t = (-4*pi+0.01):0.01:2*pi;                 % ʱ���ε�ʱ�䷶Χ(-4pi 2pi)
%���С��-2pi����Ϊ����Ҫƽ��
f = sawtooth(t);                            %����sawtooth������ݲ�
y = zeros(m+1,max(size(t)))                 %ȡt��ά�ȳ���������������������size(t)����
y(m+1,:) = f'
figure(1)
plot(t/pi+1,y(m+1,:))                      	% ���ƾ�ݲ��ź�
grid;                                            	% ��ͼ���м���դ��
axis([-2 2 -1.5 1.5])                         	% ָ��ͼ����ʾ�ĺ������귶Χ

title('���ھ�ݲ�')
xlabel('��λ��  pi','Fontsize',8)
x = zeros(size(t))  %1256
kk = '1'                                        %kk���ַ��������ܽ��д�������
for k =1:m                                      % ѭ����ʾг�����Ӳ���
    pause;                                      %�س�������
    x = x + (-1)^(k+1)*sin(k*t)/k               % �������г�����Ӻ�
    y(k,:) = x/pi*2
    plot(t/pi+1,y(m+1,:))
    hold on
    plot(t/pi,y(k,:))                          % ����г�������ź�
    hold off;                                   %����������ͼ������һ��
    grid;
    axis([-2 2 -1.5 1.5]);
    title(strcat('��', kk, '��г������'))
    xlabel('��λ��  pi','Fontsize',8)
    kk = strcat(kk,'��',num2str(k+1))           
end
pause
hold on
plot(t/pi,y(1:m,:))
plot(t/pi+1,y(m+1,:))
grid on;
axis([-2 2 -1.5 1.5])  
title('����г�����Ӳ���');
xlabel('��λ��  pi','Fontsize',8);